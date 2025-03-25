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
     - 13.sh (기존 automated test를 참고하여 테스트 스크립트 직접 구현, Python 3에서 돌아가도록 주변 파일 수정함)
     - 107.sh (기존 테스트 활용)
     - 149.sh (레포에 있는 example input 데이터를 이용하여 테스트 스크립트 직접 구현)
     - 154.sh (기존 automated test를 참고하여 테스트 스크립트 직접 구현, 필요한 부분 mocking함)
       - 비고: python에서 unicodecsv는 요즘 거의 사용되지 않으며, Python 3에서는 csv 모듈을 사용하는 것이 일반적임
       - Their official README says "The unicodecsv is a drop-in replacement for Python 2.7's csv module which supports unicode strings without a hassle. Supported versions are python 2.6, 2.7, 3.3, 3.4, 3.5, and pypy 2.4.0."
     - 197.sh (기존 automated test를 참고하여 테스트 스크립트 직접 구현)
     - 200.sh (기존 테스트 활용)
     - 202.sh (기존 테스트 활용)
     - 207.sh (다른 모듈과의 dependency가 없는 간단한 모듈이라 테스트 스크립트 직접 구현, 필요한 부분 mocking함)
     - 218.sh (다른 모듈과의 dependency가 없는 간단한 모듈이라 테스트 스크립트 직접 구현, 필요한 부분 mocking함)
     - 221.sh (다른 모듈과의 dependency가 없는 간단한 모듈이라 테스트 스크립트 직접 구현, 필요한 부분 mocking함)
     - 225.sh (기존 automated test를 참고하여 테스트 스크립트 직접 구현, 필요한 부분 mocking함)
     - 238.sh (다른 모듈과의 dependency가 없는 간단한 모듈이라 테스트 스크립트 직접 구현)
     - 283.sh (기존 테스트 활용)
     - 304.sh (기존 테스트 활용)
   
    > If the migration is successful, the output of the evaluation script should include the word "SUCCESS".

---
### Test Automation Challenges
- 2: failed to resolve dependency using setup.py
- 4: 기능에 해당하는 automated test case 부재 (테스트 자체 수정)
- 5: failed to resolve dependency on Python 2.7.18 (versions of ['lxml', 'defusedxml', 'Gooey'] are not specified)
- 6: automated test case 부재 (테스트 자체 수정)
- 8: failed to resolve dependency on Python 2.7.18 (some of the installed libraries require Python 3 syntax)
- 9: automated test case 부재
- 20: 기능에 해당하는 automated test case 부재
- 28: automated test case 부재
- 36: automated test case 부재 
- 39: automated test case 부재 & 테스트하려면 https://runkeeper.com credential 정보 필요함
- 60: 기능에 해당하는 automated test case 부재 (mycodo/tests/software_tests/test_sensors/test_all_sensors.py 참고)
- 65: failed to resolve depencency on Python 2.7.18 (pip install -r requirements/production.txt)
- 85: test case를 돌리려면 external connectivity 필요함 (명시되어 있음)
- 86: automated test case 부재
- 100: test case를 돌리려면 external resource (LOCUST_KAFKA_SERVERS 등) 셋업 필요
- 110: 기능에 해당하는 automated test case 부재 (pytest xfailed)
- 117: automated test case 부재
- 118: 기능에 해당하는 automated test case 부재
- 119: automated test case 부재 & 테스트하려면 AWS s3 credential 정보 필요함
- 120: automated test case 부재 & 테스트하려면 discogs credential 정보 필요함
- 125: automated test case 부재
- 126: failed to resolve depencency: confluent-kafka
- 132: automated test case 부재
- 153: automated test case 부재
- 177: automated test case 부재
- 175: 기능에 해당하는 automated test case 부재
  - 비고: pypandoc convert is deprecated and `convert_file` or `convert_text` can be used instead.
- 176: 기능에 해당하는 automated test case 부재
- 190: automated test case 부재 & 테스트하려면 https://poeditor.com/api/ credential 정보 필요함
- 191: 기능에 해당하는 automated test case 부재
- 193: 기능에 해당하는 automated test case 부재
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
- 303: 기능에 해당하는 automated test case 부재 (urlhelper는 테스트에서 전부 mocking되어서 사용됨)