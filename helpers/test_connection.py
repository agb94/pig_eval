import unittest
from unittest.mock import patch, MagicMock
from connection import SerfConnection, SerfConnectionError
import umsgpack


class TestSerfConnection(unittest.TestCase):

    def setUp(self):
        self.serf = SerfConnection(host='127.0.0.1', port=7373, timeout=3)

    def test_repr(self):
        expected = "SerfConnection<counter=0,host=127.0.0.1,port=7373,timeout=3>"
        self.assertEqual(repr(self.serf), expected)

    def test_counter_increments(self):
        self.assertEqual(self.serf._counter(), 0)
        self.assertEqual(self.serf._counter(), 1)
        self.assertEqual(self.serf._seq, 2)

    @patch("connection.socket.create_connection")
    def test_connect_success(self, mock_create_conn):
        mock_socket = MagicMock()
        mock_create_conn.return_value = mock_socket

        result = self.serf._connect()
        self.assertEqual(result, mock_socket)
        mock_create_conn.assert_called_once_with(('127.0.0.1', 7373), 3)

    @patch("connection.socket.create_connection", side_effect=OSError(111, "Connection refused"))
    def test_connect_failure(self, mock_create_conn):
        with self.assertRaises(SerfConnectionError) as cm:
            self.serf._connect()
        self.assertIn("Error 111 connecting 127.0.0.1:7373. Connection refused.", str(cm.exception))

    def test_call_without_handshake_raises_error(self):
        with self.assertRaises(SerfConnectionError) as cm:
            self.serf.call("mock_command", {"foo": "bar"})
        self.assertEqual(str(cm.exception), "handshake must be made first")

    @patch("connection.socket.create_connection")
    def test_handshake_sends_message(self, mock_create_conn):
        mock_socket = MagicMock()
        # Simulate message roundtrip
        def fake_recv(_):
            return umsgpack.dumps({'OK': True})

        mock_socket.recv = fake_recv
        mock_create_conn.return_value = mock_socket

        self.serf.handshake()
        # After handshake, the socket should be set and sendall called
        self.assertIsNotNone(self.serf._socket)
        mock_socket.sendall.assert_called()

    @patch("connection.socket.create_connection")
    def test_call_sends_correct_data(self, mock_create_conn):
        mock_socket = MagicMock()
        mock_socket.recv = MagicMock(return_value=umsgpack.dumps({'Response': 'success'}))
        mock_create_conn.return_value = mock_socket

        self.serf.handshake()  # sets up the connection
        response = self.serf.call("query", {"foo": "bar"})

        self.assertEqual(response, {b'Response': b'success'})
        self.assertTrue(mock_socket.sendall.called)

    @patch("connection.umsgpack.loads")
    @patch("connection.umsgpack.dumps")
    @patch("connection.socket.create_connection")
    def test_call_uses_umsgpack(self, mock_create_conn, mock_dumps, mock_loads):
        mock_socket = MagicMock()
        mock_socket.recv = MagicMock(return_value=b"dummy")
        mock_create_conn.return_value = mock_socket

        # mock 반환값 설정
        mock_dumps.side_effect = lambda obj: b"packed-" + str(obj).encode()
        mock_loads.return_value = {"response": "ok"}

        conn = SerfConnection()
        conn.handshake()  # sets up the connection

        # response = conn.call("ping", {"key": "value"})

        # 확인: umsgpack.dumps가 최소 2번 (header, body) 호출됨
        self.assertEqual(mock_dumps.call_count, 2)
        self.assertEqual(mock_loads.call_count, 1)

        # mock_loads.assert_called_once_with(b"dummy")

if __name__ == '__main__':
    unittest.main()