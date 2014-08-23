#Code is to add items.
require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"
require "../test/base"

class XeroAdd < Test::Unit::TestCase

  def setup
    super
    @content_name = Time.new.to_i
     @item_code = Time.new.to_i # to insert unique item code
     @item_description = Time.new.to_i # to insert unique item code
    self.login($ADMIN_USER, $ADMIN_PASS)

  end
def home()
    @driver.get(@base_url)
  end

  def login(username, password)
    self.home()
     @driver.manage.timeouts.implicit_wait = 30
    self.set_text_value('#email', username, true)
    self.set_text_value('#password', password, true)
    self.click_when_clickable('#submitButton')
    
  end

  def test_xero_invoice
    sleep 10

#    el = @driver.find_element(:xpath, "//*[@id='node_list']")
#@driver.mouseOver(el).perform()


# self.click_link_when_clickable('Reports', false, false)
## @driver.find_element(:id => "All Reports")
#@driver.action.move_to('Reports').click('All Reports').perform
#
##    self.click_link_when_clickable('All Reports', false, false)
##    self.click_link_when_clickable('All Reports', false, false)
#    sleep 10
#    self.click_link_when_clickable('Accounts', false, false) # to select accounts tab
    sleep 10
    self.click_when_clickable('#keyAR')
    
    $i = 1
$num=10
while $i <= $num  do
  self.set_text_value('#PaidToName_92064e8fb98d414faeb65bcaca4b471a_value', "#{@content_name}",true)


  self.select_text('#ext-comp-1001' ,"#{@item_code}",true) # to create item
    self.set_text_value('#Code',"#{@item_code}",true) 
    self.set_text_value('#edit-description', "Description is #{@item_description}",true)
    self.select_text('#PurchasesAccount_value', 'PurchasesAccount_value')
    self.click_when_clickable('#GSTCode_value')
   $i +=1
    end
  end
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end

  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
