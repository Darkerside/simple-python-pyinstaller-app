pipeline {
    agent {
        docker {
            image 'python:3.7-alpine3.17'
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'python -m py_compile sources/add2vals.py sources/calc.py'
                    stash(name: 'compiled-results', includes: 'sources/*.py*')
                }
            }
        }
        stage('Test') { 
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'pip3 install pytest'
                    sh 'python -m pytest --junit-xml test-reports/results.xml sources/test_calc.py' 
                    sh 'python -m pytest sources/test_api.py' 
                }
            }
            post {
                always {
                    junit 'test-reports/results.xml' 
                }
            }
        }
        stage('Deliver') { 
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    input message: 'Yakin untuk deploy App ke production?'
                    sh 'pip3 install pyinstaller'
                    sh 'pip3 install Flask --user'
                    sh 'chmod +x -R ./jenkins/scripts/deliver.sh'
                    sh 'chmod +x -R ./jenkins/scripts/kill.sh'
                    sh './jenkins/scripts/deliver.sh'
                    sh './jenkins/scripts/kill.sh' 
                }
            }
        }
    }
}
