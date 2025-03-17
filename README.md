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
