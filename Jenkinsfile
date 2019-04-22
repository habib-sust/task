node {
  stage('Checkout/Build/Test') {
	//Checkout Files
	checkout([
	  $class: 'GitSCM',
	  branches: [[name: 'watchKit']],
	  doGenerateSubmoduleConfigurations: false,
	  extensions: [], submodulCfg: [],
  	  userRemoteConfigs: [[
		name: 'github',
		url: 'https://github.com/shopon2024/task.git'
	    ]]
     ])

        sh 'bundle exec fastlane test'
	
	//Publish test results
	step([
	  $class: 'JUnitResultArchiver', 
	  allowEmptyResults: true, 
	  testResults: '../test-reports/report.junit'
	])

  }
}