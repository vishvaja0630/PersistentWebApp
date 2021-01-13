pipeline {
    agent any

    tools {
        // Install the Maven version configured as "Maven" and add it to the path.
        maven "Maven"
    }

    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/vishvaja0630/PersistentWebApp.git'
                
                //Create version.html
                sh 'touch src/main/webapp/version.html'
                
                //Output
                sh 'echo "version1.0" > src/main/webapp/version.html'

                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
                
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.war'
                }
            }
        }
        
        stage('Deploy')
        {   steps{
            deploy adapters: [tomcat9(credentialsId: '12b05b75-d511-4324-aded-cf9768391986', path: '', url: 'http://localhost:9090')], contextPath: 'PWA', war: 'target/PersistentWebApp.war'
                  }
        }
        stage('Show http status')
        {   steps{
                sh 'curl -I "http://localhost:9090/PWA/index.html" | grep HTTP | head -1'
                sh 'curl -v "http://localhost:9090/PWA/version.html" | egrep \'HTTP|version\''
            }
        }
    }
}

