# Analytics

[![Build Status](https://travis-ci.org/AlexisMontagne/analytics.png?branch=master)](https://travis-ci.org/AlexisMontagne/analytics)
[![Code Climate](https://codeclimate.com/repos/528d2778c7f3a335fa013259/badges/c4c17ae9f5591d5b5509/gpa.png)](https://codeclimate.com/repos/528d2778c7f3a335fa013259/feed)
[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/b9b735f530731e985ae3f291b84c4e63 "githalytics.com")](http://githalytics.com/AlexisMontagne/analytics)

A Ruby interface to the Google Analytics API.

## Installation

Add this line to your application's Gemfile:

    gem 'analytics-rb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install analytics-rb

## Usage

### Authentification

To make calls to the Google Analytics API, you have to authenticate via an API key (which you can get from the Google [APIs Console](https://code.google.com/apis/console#access). To set your API key and get started, use:

    Analytics.consumer_key    = 'your key'
    Analytics.consumer_secret = 'your secret'

Then you have to provide an access token ( OAuth or OAuth2 ) to manage or visualize statistics.
   
    client = Analytics::Client.new(Analytics::OAuth.access_token('my token', 'my secret')) # With OAuth 1.x 
    client = Analytics::Client.new(Analytics::OAuth.access_token('my token'))              # With OAuth 2.x 
    
### Management

** You can access to the accounts, web properties and profile from a `Analytics::Client` 
    
    client.accounts        # returns an array of Analytics::Account
    client.web_properties  # returns an array of Analytics::WebProperty
    client.profiles        # returns an array of Analytics::Profile

### Reporting

From a `Analyics::Profile` you can access to the report object
  
    profile.report
    # or 
    Analyics::Report.new('profile_id', access_token) # access_token is a OAuth::AccessToken or  OAuth2::AccessToken

You can grab datas with a simple DSL

    report.visits(0, Time.now) # it should grab all visits from Jan 1st 1970 to now
    # you can provide all metrics from google analytics ( visitors, new_visits, percent_new_visits, ... )
  
    # you can provide a metric and a dimension
    report.visits_by_month(0, Time.now)

    # you can provide multiple metrics and dimensions as well
    report.visists_and_visitors_by_month_and_city(0, Time.now)

  
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
