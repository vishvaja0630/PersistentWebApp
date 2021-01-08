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
            deploy adapters: [tomcat9(credentialsId: '12b05b75-d511-4324-aded-cf9768391986', path: '', url: 'http://ec2-3-17-71-20.us-east-2.compute.amazonaws.com:9090')], contextPath: 'PWA', war: 'target/PersistentWebApp.war'
        }
        }
    }
}
