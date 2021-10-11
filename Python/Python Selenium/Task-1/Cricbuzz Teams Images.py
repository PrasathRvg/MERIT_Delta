driver=webdriver.Chrome(r"C:\Users\Merit\Downloads\chromedriver_win32\chromedriver.exe")
driver.get("https://www.cricbuzz.com/")
time.sleep(1)
driver.find_element_by_xpath("//nav[@id='cb-main-menu']//preceding::a[contains(text(),'Teams')]").click()
countries=driver.find_elements_by_xpath("//div[contains(@class,'cb-col cb-col-67')]")
lst= []
for i in countries:
    lst.append(i.text)
    lst1=lst[0].split('\n')
img=driver.find_elements_by_xpath("//div[contains(@class,'cb-col cb-col-25')]")
for i,j in zip(img,lst1):    
    with open(j+".png","wb") as image:
        image.write(i.screenshot_as_png)
driver.close()