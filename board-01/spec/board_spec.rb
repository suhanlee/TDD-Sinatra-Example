require File.expand_path '../spec_helper.rb', __FILE__

describe 'Board Path (/)' do
  it "should return index string" do
    get '/'
    expect(last_response.body).to include('index')
  end

  it "find new page link" do
    NEW_LINK = '<a href="/new">New</a>'

    get '/'
    expect(last_response.body).to include(NEW_LINK)
  end

  it "show totla article number field" do
    article_count = Article.count
    TOTAL_ARTICLE = "total: " + article_count.to_s

    get '/'
    expect(last_response.body).to include(TOTAL_ARTICLE)
  end
end

describe 'Board Path (/new)' do
  it "find form field in new page" do
    AUTHOR_FORM_FIELD = '<input type="text" name="author">'

    get '/new'
    expect(last_response.body).to include(AUTHOR_FORM_FIELD)
  end

  it "find subject form in new page" do
    SUBJECT_FORM_FIELD = '<input type="text" name="subject">'

    get '/new'
    expect(last_response.body).to include(SUBJECT_FORM_FIELD)
  end

  it "find contents form in new page" do
    CONTENTS_FORM_FIELD = '<textarea name="contents"></textarea>'

    get '/new'
    expect(last_response.body).to include(CONTENTS_FORM_FIELD)
  end

  it "after posting article, redirect to index page" do
    test_author = 'test author'
    test_subject = 'test subject'
    test_contents = 'test contents'

    post '/new', :author => test_author,
         :subject => test_subject,
         :test_contents => test_contents

    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.url).to eq('http://example.org/')
  end
end