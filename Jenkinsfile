pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
        // stage('Compile') {
        //     agent {
        //         docker {
        //             image 'python:3.7-alpine3.17'
        //         }
        //     }
        //     steps {
        //         withEnv(["HOME=${env.WORKSPACE}"]) {
        //             sh 'python -m py_compile sources/add2vals.py sources/calc.py'
        //             stash(name: 'compiled-results', includes: 'sources/*.py*')
        //         }
        //     }
        // }
        // stage('Test') {
        //     agent {
        //         docker {
        //             image 'python:3.7-alpine3.17'
        //         }
        //     }
        //     steps {
        //         withEnv(["HOME=${env.WORKSPACE}"]) {
        //             sh 'pip3 install pytest'
        //             sh 'python -m pytest --junit-xml test-reports/results.xml sources/test_calc.py' 
        //             sh 'python -m pytest sources/test_api.py' 
        //         }
        //     }
        //     post {
        //         always {
        //             junit 'test-reports/results.xml' 
        //         }
        //     }
        // }
        stage('Generate Exec') {
            agent any
            environment { 
                VOLUME = '$(pwd)/sources:/src'
                IMAGE = 'cdrx/pyinstaller-linux:python3'
            }
            steps {
                dir(path: env.BUILD_ID) { 
                    // unstash(name: 'compiled-results') 
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'pyinstaller -F add2vals.py'" 
                    sh "cp ./sources/dist/add2vals ~/add2vals"
                }
            }
            post {
                success {
                    sh "docker run --rm -v ${VOLUME} ${IMAGE} 'rm -rf build dist'"
                }
            }
        }
        stage('Deploy') {
            steps {
                input message: 'Yakin untuk deploy App ke production?'
                sh 'chmod +x -R ./jenkins/scripts/deliver.sh'
                sh 'chmod +x -R ./jenkins/scripts/kill.sh'
                sh './jenkins/scripts/deliver.sh'
                sshagent(credentials: ['ec2jenkinfile']) {
                    sh "rsync -auvvzr --rsh 'ssh ssh -o StrictHostKeyChecking=no' ~/pythonapp/ ec2-user@ec2-13-229-219-204.ap-southeast-1.compute.amazonaws.com:/home/ec2-user/pythonapp/"
                }
                sh './jenkins/scripts/kill.sh'
            }
        }
    }
}
