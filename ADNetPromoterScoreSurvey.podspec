#  Be sure to run `pod spec lint ADNetPromoterScoreSurvey.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.

Pod::Spec.new do |s|

  s.name         = "ADNetPromoterScoreSurvey"
  s.version      = "1.0.0"
  s.summary      = "An iOS Net Promoter Score Survey"

  s.description  = <<-DESC
    Net Promoter or Net Promoter Score (NPS) is a management tool that can be used to gauge the loyalty of a firm's customer relationships. 
    It serves as an alternative to traditional customer satisfaction research and claims to be correlated with revenue growth. 
    NPS has been widely adopted with more than two thirds of Fortune 1000 companies using the metric.
                   DESC

  s.homepage     = "http://autodesk.com"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"

  s.author             = { "Tomer Shalom" => "tomer.shalom@autodesk.com" }
  s.social_media_url   = "http://twitter.com/applitom"

  s.platform     = :ios, "9.0"

  s.source       = { :git => ".", :tag => "#{s.version}" }

  s.source_files  = "ADNetPromoterScoreSurvey/**/*.{h,m,swift}"

  s.resources = "ADNetPromoterScoreSurvey/**/*.{xib,xcassets}"
  
end
