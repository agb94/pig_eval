1. Start the Docker containers in detached mode:  
   ```bash
   docker-compose up --build --detach
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
     - 1.sh (다른 모듈과의 dependency가 없는 간단한 모듈이라 테스트 스크립트 직접 구현)
     - 107.sh (기존 테스트 활용)
     - 197.sh (기존 automated test를 참고하여 테스트 스크립트 직접 구현)
     - 200.sh (기존 테스트 활용)
     - 202.sh (기존 테스트 활용)
     - 207.sh (다른 모듈과의 dependency가 없는 간단한 모듈이라 테스트 스크립트 직접 구현, 필요한 부분 mocking함)
     - 218.sh (다른 모듈과의 dependency가 없는 간단한 모듈이라 테스트 스크립트 직접 구현, 필요한 부분 mocking함)
       - 218a.py 확인 필요
     - 221.sh (다른 모듈과의 dependency가 없는 간단한 모듈이라 테스트 스크립트 직접 구현, 필요한 부분 mocking함)
     - 225.sh (기존 automated test를 참고하여 테스트 스크립트 직접 구현, 필요한 부분 mocking함)
     - 238.sh (다른 모듈과의 dependency가 없는 간단한 모듈이라 테스트 스크립트 직접 구현)
     - 283.sh (기존 테스트 활용)
   
    > If the migration is successful, the output of the evaluation script should include the word "SUCCESS".

---
### Test Automation Challenges
- 6: automated test case 부재 (테스트 자체 수정)
- 9: automated test case 부재
- 28: automated test case 부재
- 36: automated test case 부재 
- 39: automated test case 부재 & 테스트하려면 https://runkeeper.com credential 정보 필요함
- 86: automated test case 부재
- 117: automated test case 부재
- 119: automated test case 부재 & 테스트하려면 AWS s3 credential 정보 필요함
- 120: automated test case 부재 & 테스트하려면 discogs credential 정보 필요함
- 132: automated test case 부재
- 153: automated test case 부재
- 177: automated test case 부재
- 199: automated test case 부재
- 203: automated test case 부재 & 테스트하려면 slack token등 credential 정보 필요함
- 205: automated test case 부재
- 233: automated test case 부재
- 236: automated test case 부재 & Dependency 설치 이슈 (No matching distribution found for eventlet==0.17.3)
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

### Remaining 
- 2
- 4
- 5
- 8: test는 없지만 짤수있어보임
- 13
- 20
- 60
- 65
- 85
- 100: external resource (LOCUST_KAFKA_SERVERS) 셋업 필요
- 110
- 118
- 125: test는 없지만 짤수있어보임
- 126
- 149
- 154
- 175
- 176
- 190
- 191
- 193
