pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'python:3.7-alpine3.17'
                }
            }
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'python -m py_compile sources/add2vals.py sources/calc.py'
                    sh 'pip3 install --upgrade pip && pip3 install wheel'
                    sh 'pip3 install Flask --user'
                    stash(name: 'compiled-results', includes: 'sources/*.py*')
                }
            }
        }
        stage('Test') { 
            agent {
                docker {
                    image 'qnib/pytest' 
                }
            }
            steps {
                sh 'py.test --junit-xml test-reports/results.xml sources/test_calc.py' 
            }
            post {
                always {
                    junit 'test-reports/results.xml' 
                }
            }
        }
        stage('Deploy') { 
            agent {
                docker {
                    image 'cdrx/pyinstaller-linux:latest'
                }
            }
            steps {
                input message: 'Yakin untuk deploy App ke production?' 
                sh './jenkins/scripts/deliver.sh'
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}
