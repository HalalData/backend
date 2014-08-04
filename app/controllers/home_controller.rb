class HomeController < ApplicationController
  def index
  end

  def show
  	client = Elasticsearch::Client.new host: '10.130.220.111:9200'
  	places = client.search index: 'places', body: { query: { query_string: { query: params['query'] } } }
  	
  	@Places = Kaminari.paginate_array(places['hits']['hits']).page(params['page'])
  end
end
