import unittest
import datetime
from stats import (
    RTCStatsReport,
    RTCInboundRtpStreamStats,
    RTCOutboundRtpStreamStats,
    RTCRemoteInboundRtpStreamStats,
    RTCRemoteOutboundRtpStreamStats,
    RTCTransportStats,
)

class TestRTCStats(unittest.TestCase):
    def setUp(self):
        self.timestamp = datetime.datetime.utcnow()

    def test_inbound_rtp_stream_stats(self):
        stats = RTCInboundRtpStreamStats(
            timestamp=self.timestamp,
            type="inbound-rtp",
            id="inbound1",
            ssrc=1234,
            kind="video",
            transportId="transport1",
            packetsReceived=100,
            packetsLost=2,
            jitter=5,
        )
        self.assertEqual(stats.type, "inbound-rtp")
        self.assertEqual(stats.packetsLost, 2)

    def test_outbound_rtp_stream_stats(self):
        stats = RTCOutboundRtpStreamStats(
            timestamp=self.timestamp,
            type="outbound-rtp",
            id="outbound1",
            ssrc=5678,
            kind="audio",
            transportId="transport2",
            packetsSent=200,
            bytesSent=40000,
            trackId="track123",
        )
        self.assertEqual(stats.trackId, "track123")
        self.assertEqual(stats.bytesSent, 40000)

    def test_remote_inbound_rtp_stream_stats(self):
        stats = RTCRemoteInboundRtpStreamStats(
            timestamp=self.timestamp,
            type="remote-inbound-rtp",
            id="remote-inbound1",
            ssrc=9999,
            kind="video",
            transportId="transport3",
            packetsReceived=120,
            packetsLost=1,
            jitter=3,
            roundTripTime=0.045,
            fractionLost=0.01,
        )
        self.assertAlmostEqual(stats.roundTripTime, 0.045)

    def test_remote_outbound_rtp_stream_stats(self):
        stats = RTCRemoteOutboundRtpStreamStats(
            timestamp=self.timestamp,
            type="remote-outbound-rtp",
            id="remote-outbound1",
            ssrc=2222,
            kind="audio",
            transportId="transport4",
            packetsSent=180,
            bytesSent=30000,
            remoteTimestamp=self.timestamp,
        )
        self.assertEqual(stats.remoteTimestamp, self.timestamp)

    def test_transport_stats(self):
        stats = RTCTransportStats(
            timestamp=self.timestamp,
            type="transport",
            id="transport1",
            packetsSent=300,
            packetsReceived=290,
            bytesSent=120000,
            bytesReceived=110000,
            iceRole="controlling",
            dtlsState="connected",
        )
        self.assertEqual(stats.iceRole, "controlling")

    def test_rtc_stats_report_add_and_lookup(self):
        report = RTCStatsReport()
        inbound_stats = RTCInboundRtpStreamStats(
            timestamp=self.timestamp,
            type="inbound-rtp",
            id="stat1",
            ssrc=1111,
            kind="video",
            transportId="t1",
            packetsReceived=100,
            packetsLost=5,
            jitter=2,
        )
        report.add(inbound_stats)
        self.assertIn("stat1", report)
        self.assertEqual(report["stat1"].packetsLost, 5)

    def test_dataclass_equality(self):
        stats1 = RTCTransportStats(
            timestamp=self.timestamp,
            type="transport",
            id="t1",
            packetsSent=1,
            packetsReceived=2,
            bytesSent=3,
            bytesReceived=4,
            iceRole="controlling",
            dtlsState="connected",
        )
        stats2 = RTCTransportStats(
            timestamp=self.timestamp,
            type="transport",
            id="t1",
            packetsSent=1,
            packetsReceived=2,
            bytesSent=3,
            bytesReceived=4,
            iceRole="controlling",
            dtlsState="connected",
        )
        self.assertEqual(stats1, stats2)

if __name__ == "__main__":
    unittest.main()
