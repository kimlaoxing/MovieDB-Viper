# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MovieDB-Viper' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MovieDB-Viper

use_frameworks!

workspace 'MovieDB-Viper'

def core_pods
pod 'Toast-Swift', '~> 5.0.1'
pod 'SwiftLint'
pod 'Declayout'
pod 'Alamofire'
pod 'YoutubeKit'
end

target 'Router' do
project 'Router/Router.project'
end

target 'Components' do
project 'Components/Components.project'
core_pods
end

target 'Home' do
project 'Home/Home.project'
core_pods
end

target 'MovieDB-Viper' do
project 'MovieDB-Viper.project'
core_pods
end

end
