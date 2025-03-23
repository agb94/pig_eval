1. Start the Docker containers in detached mode:  
   ```bash
   docker-compose up --detach
   ```

2. Locate the file to be evaluated in the `./files_to_test` directory.

3. Run the following command to execute the evaluation script on the selected file:  
   ```bash
   docker exec pig_eval-test-runner-1 bash /root/commands/107.sh {filename_to_test}
   ```
   For example, to evaluate `107a.py`, use:  
   ```bash
   docker exec pig_eval-test-runner-1 bash /root/commands/107.sh 107a.py
   ```

   - List of commands
     - 1.sh (다른 모듈과의 dependency가 없는 간단한 change여서 automated test 직접 구현)
     - 107.sh
     - 238.sh (다른 모듈과의 dependency가 없는 간단한 change여서 automated test 직접 구현)
     - 283.sh

---

- 251: 기능에 해당하는 automated test case 부재
- 254: automated test case 부재
- 265: automated test case 부재
- 268: automated test case 부재
- 272: automated test case 부재
- 273: require external resources (Need to fetch the P12 certificate from BankID servers to run the test)
- 280: automated test case 부재
- 282: automated test case 부재
- 284: automated test case 부재
- 293: automated test case 부재 + GUI-related functionality
- 303: requires old python version (2.6.0)
- 304: requires old python version (2.6.0)
