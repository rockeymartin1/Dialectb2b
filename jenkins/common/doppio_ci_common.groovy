//This is a common function for runner            
//Global runner config
testpath = "./testcases"
retryprefix = "--prerunmodifier DataDriver.rerunfailed:output.xml --output rerun.xml -r rerunreport.html"
max_retry = 3
//Android runner config
android_concurrent = "--processes "
android_resourcefile = "--resourcefile "
android_variable = "-v app:'/Users/woody/woody_farm/woody_upload/nimble_kbol/android/#app_version#/#app_version#.apk' -v doppio_farm:True -v PLATFORM:android -v lang:#lang#"
//iOS runner config
ios_concurrent = "--processes "
ios_resourcefile = "--resourcefile "
ios_variable = "-v app:'/Users/woody/woody_farm/woody_upload/nimble_kbol/ios/#app_version#/#app_version#.app' -v doppio_farm:True -v PLATFORM:ios -v lang:#lang#"

def mobile_run_test_with_retry(platform,includeTag,appVersion,lang,RESOURCE_FILE_PATH,PROCESSES){
    if (platform == "android"){
        variable = android_variable
        concurrent = android_concurrent + PROCESSES
        resourcefile = android_resourcefile + RESOURCE_FILE_PATH
        testpath = "./testcases/mobile"
    }
    else if (platform =="ios"){
        variable = ios_variable
        concurrent = ios_concurrent + PROCESSES
        resourcefile = ios_resourcefile + RESOURCE_FILE_PATH
        testpath = "./testcases/mobile"
    }
    variable = variable.replace("#app_version#",appVersion)
    variable = variable.replace("#lang#",lang)
    
    try {
        sh "pabot --pabotlib --pabotlibport 13590 ${concurrent} ${resourcefile} ${includeTag} ${variable} ${testpath}"
        sh 'echo "finish running 1st round"'
    }
    catch (err) {       //if test failed
        def needRetry = true
        for(int i =0; i<max_retry; i++){
            if (needRetry){
            try{
                echo "Running retry logic ${i}"
                sh "pabot --pabotlib --pabotlibport 13590 ${concurrent} ${resourcefile} ${retryprefix} ${variable} ${testpath}"
                needRetry = false
            }
            catch (err2){
                echo "Nothing need to implement"
            }
        
            try{
                sh 'rebot  -r final_report -o final_report --merge output.xml rerun.xml'
            }
            catch (err3) {
                echo "Nothing need to implement"
            }
            try {
                sh """
                echo 'Merged result done'
                mv report.html ${i}_report.html
                mv output.xml ${i}_output.xml
                mv final_report.xml output.xml
                mv final_report.html report.html
                echo 'Rename result done'
                """
            }
            catch (err4){
                echo "nothing to rename"
            }
        }
        }
    }
        
}
def get_available_device(apikey,platform,version,numberOfInstances,slotIdleTimeout,resourceFilePath){
      try {
         def BORROW_KEY = "default"
         BORROW_KEY = sh (
                              script: """curl --location -s -o ${resourceFilePath} \
                              --request GET '125.26.15.143:5001/get_available_devices?platform=${platform}&version=${version}&numberOfInstances=${numberOfInstances}&slotIdleTimeout=${slotIdleTimeout}' \
                              --header 'x-api-key: ${apikey}'  -D - | grep borrow_key | sed \'s/borrow_key: //g\'""",
                              returnStdout: true
                        ).trim()
         echo "BORROW_KEY: ${BORROW_KEY}"
         env.BORROW_KEY = "${BORROW_KEY}"        
         sh "cat ${resourceFilePath}" 
      } catch (ee1) {
               echo "error, something went wrong when trying to get available devices"
      }
      try {
         echo "BORROW_KEY inside try: ${BORROW_KEY}"
         if (BORROW_KEY ==  "") {
            currentBuild.result = "FAILED"
            echo "ERROR: failed to get borrow_key, exising the build...."
            throw new RuntimeException("failed to get borrow_key, exiting the build....")
         }
         else {
            echo "YES, we have BORROW_KEY"
         }
      } //end try
      catch (e) {
         currentBuild.result = "FAILED"
         throw e
      } // end catch

      return "${BORROW_KEY}"
}

def release_devices(apikey,borrowKey){
      echo "BORROW_KEY: ${borrowKey}" 
      sh """
         curl --location --request GET '125.26.15.143:5001/release_devices' \
         --header 'x-api-key: ${apikey}' \
         --header 'borrow_key: ${borrowKey}'
      """
}

def web_run_test_with_retry(testcaseDir,includeTag,thread,runVariable,hagridVersion){
    // example of runVariable
    // -v lang:$LANG
    def CONTAINER_TEST_DIR = "/robot"
    CONTAINER_TEST_DIR = "/robot" + testcaseDir
    echo "CONTAINER_TEST_DIR: ${CONTAINER_TEST_DIR}"
    try{
        withCredentials([usernamePassword( credentialsId: 'docker-login', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
            sh """
            docker login -u $USER -p $PASSWORD
            docker run -m 8G --cpus='4.0' --name hagrid_$BUILD_NUMBER \
            -v /dev/shm:/dev/shm \
            -v $WORKSPACE/reports:/robot/reports \
            -v $WORKSPACE:/robot/testcases \
            -e PABOT_OPTIONS='--pabotlib' \
            -e ROBOT_THREADS=${thread} \
            -e ROBOT_TESTS_DIR='${CONTAINER_TEST_DIR}' \
            -e ROBOT_OPTIONS='${includeTag} ${runVariable} --outputdir /robot/reports' \
            doppiotech/rbf-with-browser:${hagridVersion}
            """
        }//end withCredentials
    }// end try
    catch(err){
        def max_retry = 3
        for(int i =0; i<max_retry; i++){
            sh "docker stop hagrid_$BUILD_NUMBER"
            sh "docker rm -f hagrid_$BUILD_NUMBER"
            echo "removed container hagrid_$BUILD_NUMBER"
            try{
                echo "Running retry logic ${i}"
                sh "docker run -m 8G --cpus='4.0' --name hagrid_$BUILD_NUMBER \
                -v /dev/shm:/dev/shm \
                -v $WORKSPACE/reports:/robot/reports \
                -v $WORKSPACE:/robot/testcases \
                -e PABOT_OPTIONS='--pabotlib --prerunmodifier DataDriver.rerunfailed:/robot/reports/output.xml --output rerun.xml -r rerunreport.html' \
                -e ROBOT_THREADS=${thread} \
                -e ROBOT_TESTS_DIR='${CONTAINER_TEST_DIR}' \
                -e ROBOT_OPTIONS='${runVariable} --outputdir /robot/reports' \
                doppiotech/rbf-with-browser:${hagridVersion}"
            }
            catch (err2){
                echo "Nothing need to implement"
            }
            try{
                sh 'rebot -r reports/final_report -o reports/final_report -l reports/log --merge reports/output.xml  reports/rerun.xml'
            }
            catch (err3){
                echo "Nothing need to implement"
            }
            try {
                sh """
                echo 'Merged result done'
                mv reports/report.html reports/${i}_report.html
                mv reports/output.xml reports/${i}_output.xml
                mv reports/final_report.xml reports/output.xml
                mv reports/final_report.html reports/report.html
                echo 'Rename result done'
                """
            }
            catch (err4){
                echo "nothing to rename"
            }
        }//end for

    }// end catch    

}// end web_run_test_with_retry

def notify_result_to_slack(channel){
        echo "Publish Robot Framework test results"
        def prefix = ":white_check_mark:"
        def failed_count = tm('${ROBOT_FAILED}').toInteger()
        def passed_count = tm('${ROBOT_PASSED}').toInteger()
        if (tm('${ROBOT_FAILED}').toInteger() > 0) {
            prefix = ":firecracker:"
        } 
        def robotlog = "${BUILD_URL}" + "/robot/report/log.html"
        robotlog = robotlog.replaceAll( 'localhost', 'doppio-tech.com' )
        echo "${robotlog}"
        def full_msg = "${prefix}  ${JOB_NAME}  #${BUILD_NUMBER} \n *BRANCH* : ${GIT_BRANCH} \n passed : ${passed_count} \n failed : ${failed_count} \n after ${currentBuild.durationString} \n (<${robotlog}|Report>)"
        env.NOTI_MSG = "${full_msg}"
        slackSend(channel: "${channel}", message:  "${full_msg}")

}// end notify_result_to_slack



def notify_result_to_line(lineToken){
        echo "sending result to line"
        def failed_count = tm('${ROBOT_FAILED}').toInteger()
        def passed_count = tm('${ROBOT_PASSED}').toInteger()
        def robotlog = "${BUILD_URL}" + "/robot/report/log.html"
        robotlog = robotlog.replaceAll( 'localhost', 'doppio-tech.com' )
        sh """curl --location --request POST 'https://notify-api.line.me/api/notify' \
        --header 'Authorization: Bearer ${lineToken}' \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --data-urlencode 'message= ${JOB_NAME}
        PASS : ${passed_count}  
        FAIL : ${failed_count} 
        URL : ${robotlog}'"""

}  

def notify_result_to_dumbledore(){
    try {
        def JOB_GIT_URL= 'https://patamaporn.h@gitlab.com/doppiotech/dumbledore.git'
        def JOB_GIT_BRANCH= 'main'
        def GIT_CREDENTIAL= 'a8ac8982-0d5a-459d-809f-eda950edbc49'
        echo "Downloading GIT Code from: ${JOB_GIT_URL}. Branch: ${JOB_GIT_BRANCH}"
        checkout([$class: "GitSCM", branches: [[name: "${JOB_GIT_BRANCH}"]], doGenerateSubmoduleConfigurations: false,
        extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: "${GIT_CREDENTIAL}",
        url: "${JOB_GIT_URL}"]]])
    } catch (err) {
        echo "The Download GIT Code Stage failed"
    }
    sh '''
    python3 ./robotframework_parser.py  "${JOB_NAME}"
    '''
}

def notify_result_to_dumbledore_v2(report_html_file,output_xml_file){
    try{
        echo "report_html_file : ${report_html_file}"
        echo "output_xml_file : ${output_xml_file}"
        sh "ls -la ${WORKSPACE}"
        sh """
        curl --location --request POST 'http://125.26.15.143:21000/upload_result' \
            --form 'report_html_file=@"${report_html_file}"' \
            --form 'output_xml_file=@"${output_xml_file}"' \
            --form 'job_name="${JOB_NAME}"' \
            --form 'build_url="${BUILD_URL}"' \
            --form 'build_number="${BUILD_NUMBER}"' \
            --form 'branch_name="${GIT_BRANCH}"' \
            --form 'log_type="robot"'
        """
    }
    catch(err){
        echo "error while notifying_result_to_dumbledore_v2"
    }
}

def stop_hagrid_container(){
    try{
        sh "docker stop hagrid_$BUILD_NUMBER"
        sh "docker rm -f hagrid_$BUILD_NUMBER"
        echo "removed container hagrid_$BUILD_NUMBER"
    }
    catch(err){
        echo "error while stopiing hargrid container"
    }
}

def report_sender(){
        withCredentials([usernamePassword( credentialsId: 'docker-login', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
        sh """
        docker login -u $USER -p $PASSWORD
        docker run --name report_sender_SCG_E_Ordering_$BUILD_NUMBER \
        -v $WORKSPACE:/result_log \
        -e BUILD_URL=$BUILD_URL \
        -e BUILD_NUMBER=$BUILD_NUMBER \
        -e BUILD_TYPE="${BUILD_TYPE}" \
        -e GIT_BRANCH="${BRANCH}" \
        -e COMPANY_ID="${COMPANY_ID}" \
        -e PROJECT_ID="${PROJECT_ID}" \
        -e JOB_NAME=${JOB_NAME} \
        -e REPORT_PATH="reports/output.xml" \
        -e SCREENSHOT_FOLDER="reports" \
        -e TYPE="${TYPE}" \
        -e AUTOMATED_VERSION="${AUTOMATED_VERSION}" \
        -e APP_VERSION="${APP_VERSION}" \
        doppiotech/doppio_report_sender:${REPORT_SENDER_VERSION}

        docker logs report_sender_SCG_E_Ordering_$BUILD_NUMBER
        docker stop report_sender_SCG_E_Ordering_$BUILD_NUMBER
        docker rm -f report_sender_SCG_E_Ordering_$BUILD_NUMBER
        docker rmi -f doppiotech/doppio_report_sender:${REPORT_SENDER_VERSION}
        """
        }//end withCredentials    
}

return this

def send_success_result_to_pr(){
    withCredentials([usernamePassword(credentialsId: 'scg-bigth-github', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        sh """
        curl \"${git_status_url}\" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${PASSWORD}" \
        -X POST \
        -d "{\\"state\\": \\"success\\",\\"context\\": \\"continuous-integration/jenkins\\", \\"description\\": \\"Jenkins\\", \\"target_url\\": \\"http://doppio-tech.com:8080/job/SCG_E-Ordering/job/dryrun/$BUILD_NUMBER/console\\"}"
    """
    }
}
def send_faild_result_to_pr(){
    withCredentials([usernamePassword(credentialsId: 'scg-bigth-github', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        sh """
        curl \"${git_status_url}\" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${PASSWORD}" \
        -X POST \
        -d "{\\"state\\": \\"failure\\",\\"context\\": \\"continuous-integration/jenkins\\", \\"description\\": \\"Jenkins\\", \\"target_url\\": \\"http://doppio-tech.com:8080/job/SCG_E-Ordering/job/dryrun/$BUILD_NUMBER/console\\"}"
    """
    }
    
}

def notify_result_to_ms_teams(webhook_url){
    try{
        echo "sending ms team noti"
        def status_color = "00ff5f"
        def robotlog = "${BUILD_URL}" + "/robot/report/log.html"
        robotlog = robotlog.replaceAll( 'localhost', 'doppio-tech.com' )
        def failed_count = tm('${ROBOT_FAILED}').toInteger()
        def passed_count = tm('${ROBOT_PASSED}').toInteger()
        def total_count = failed_count + passed_count
        echo "Total Count: ${total_count}"
        echo "failed${failed_count}"
        echo "passed${passed_count}"
        if (failed_count > 0) {
            status_color = "ff0000"
        }
        def msg_result = "${JOB_NAME}#${BUILD_NUMBER}---Total:(${total_count})---Passed:(${passed_count})---Failed:(${failed_count})---After:${currentBuild.durationString}---[See_log](${robotlog})"
        sh """curl -k --location \"${webhook_url}\" --header \"Content-Type: application/json\" --data-raw \"{\\\"type\\\": \\\"MessageCard\\\",\\\"summary\\\": \\\"summary\\\",\\\"themeColor\\\": \\\"${status_color}\\\",\\\"sections\\\": [{\\\"activityTitle\\\": \\\"**${JOB_NAME}**\\\",\\\"facts\\\":[{\\\"name\\\": \\\"BUILD NO.\\\",\\\"value\\\": \\\"#${BUILD_NUMBER}\\\"},{\\\"name\\\": \\\"BRANCH\\\",\\\"value\\\": \\\"${GIT_BRANCH}\\\"},{\\\"name\\\": \\\"TOTAL TC\\\",\\\"value\\\": \\\"${total_count}\\\"},{\\\"name\\\": \\\"PASSED\\\",\\\"value\\\": \\\"${passed_count}\\\"},{\\\"name\\\": \\\"FAILED\\\",\\\"value\\\": \\\"${failed_count}\\\"},{\\\"name\\\": \\\"DURATIONS\\\",\\\"value\\\": \\\"${currentBuild.durationString}\\\"}]},{\\\"potentialAction\\\": [{\\\"@type\\\": \\\"OpenUri\\\",\\\"name\\\": \\\"Report\\\",\\\"targets\\\": [{\\\"os\\\": \\\"default\\\",\\\"uri\\\": \\\"${robotlog}\\\"}]}]}]}\""""
    }catch(err){
        echo "error while report_ms_team_sender: ${err}"
    }
}