# Fyber Offer API

A simple rails app that consumes Fyber Offer API.

Live demo on Heroku: http://protected-cove-9472.herokuapp.com/
  

# Clone and run

```sh
git clone https://github.com/gutomcosta/fyber-offer-api.git
```

```sh
bundle install
```

```sh
rails s
```

Go to localhost:3000

### API Configuration

All the configuration used to access the api are on the environment files.
I decided to put this configuration in these files, because of rails convention. With this is possible to have different configurations for each environment settings. For this case, the configurations are the same for all environments.

Example:

```ruby
  config.offer_appid 
  config.offer_format
  config.offer_device_id
  config.offer_locale
  config.offer_ip
  config.offer_offer_types 
  config.offer_api_key
  config.offer_url
```

# General overview of my approach

I used an outside in approach to develop this application. I tried to keep all features more end-to-end as possible. I like to use the [Walking Skeleton](http://alistair.cockburn.us/Walking+skeleton) for this.
For the test approach, I used a mix of BDD and TDD cycles. I'm big fan of mock objects, and during my TDD cycle, I used the mocks to discovery the messages that objects send each other.

#### Rails app

To abstract the request parameters, I used a Form Object. With this, is possible to validate the params, and give the necessary semantic for the request params.

```ruby
@form = OfferSearchForm.new(params[:offers])
if @form.valid? 
    ....
```

Another important concept that I used, is the Use Case. My controller doesn't know anything about the business logic. It's encapsulated in the Use Case Object.


```ruby
 use_case = SearchOffer.build(load_offer_api_config, offer_url)
 @offers = use_case.execute({
     uid: @form.uid, 
     pub0: @form.pub0, 
     page: @form.page
 })
```
I modeled an Offer as a Rails Model.
To manipulate the API request Params, I used an OfferParam. It's a value object, that is responsible to all Offer API params manipulation logic.

For example:
* sort the params in alphabetical order
* concatenate with the API key
* gets a hashkey
* build the request params correct

```ruby
class OfferParam

  def build
    params             = concatenate(sorted_params)
    params_to_hashkey  = with_api_key(params.clone)
    hashkey            = Hashkey.new(params_to_hashkey)
    value = with_hashkey(params,hashkey.get)
    value
  end
````
The Hashkey object, encapsulates the hashkey generation.

#### Todo

* write functional tests with capybara and selenium
* add an ajax loading on request
* improve error handling and log


