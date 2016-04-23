# TDD-Sinatra-Example
TDD(Test Driven Development) 방법론으로 Sinatra Project를 만들때 참고할만한 예제 및 가이드 정보를 작성한 것입니다.

# Example
- [rspec-01](https://github.com/suhanlee/TDD-Sinatra-Example/tree/master/rspec-01)
- [mock-01](https://github.com/suhanlee/TDD-Sinatra-Example/tree/master/mock-01)

## 변경사항에 대한 파일 자동 로딩
```ruby
configure :development do
	use Rack::Reloader
end
```

## RSpec & Rack Test사용
```ruby
# Gemfile
group :test, :development do
	gem 'rspec'
end

group :test do
	gem 'rack-test'
end

# spec/spec_helper.rb
require 'rack/test'
require 'rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FIlE__

RSpec.configure do |config|
	include Rack::Test::Methods
	
	def app
		SimpleApp
	end
end
```

## RSpec Basic Test Case
```ruby
require File.expand_path '../spec_helper.rb', __FILE__

describe 'Hello Path' do
	it 'should return hello string' do
		get '/hello'
		
		expect(last_response.body).to eq('hello')
	end
end
```

## RSpec let Example
```ruby
require File.expand_path '../spec_helper.rb', __FILE__

describe 'Json Path' do
  describe 'json/' do
    let(:body) { { :version => "1.2.3" }.to_json }
    before do
      post '/json', body, {'Content-Type' => 'application/json'}
    end

    it 'is successful' do
      expect(last_response.body).to eq body
    end
  end
end
```

## Sinatra Modular 형식
```ruby
# config.ru(run with rackup)
require './app'
run SimpleApp

# app.rb
class SimpleApp < Sinatra::Base
...
end
```

## ActiveRecord 사용
```ruby
# Gemfile
gem 'sinatra-activerecord'

# app.rb
require 'sinatra/activerecord'
...
class Article < ActiveRecord::Base
end
...
class SimpleApp < Sinatra::Base
register Sinatra::ActiveRecordExtension
```

## ActiveRecord & App Rake 등록
```ruby
# Gemfile
gem 'rake'

# Rakefile
require 'sinatra/activerecord/rake'

namespace :db do
	task :load_config do
		require './app'
	end
end
```

## Sqlite DB 지정
```ruby
# app.rb
set :database, {adapter: "sqlite3", database: "database.sqlite3"}
```

## Session 사용
```ruby
# app.rb
enable :sessions unless test?
...
session[name] = data
session[name].to_s
```

## JSON 응답
```ruby
require 'json'

begin
	payload = JSON.parse(request.body.read)
	payload.to_json
rescue Exception => e
	puts e.message
	puts e.backtrace.inspect
```
