driver= webdriver.Chrome(executable_path=r"C:\Users\Merit\Downloads\chromedriver_win32\chromedriver.exe")
driver.get("https://ai.fmcsa.dot.gov/hhg/Search.asp?ads=a")
driver.maximize_window()
time.sleep(1)
st=driver.find_elements_by_xpath("//option[contains(text(),'Please select state')]//following::option")
time.sleep(1)
States=[]
writer=pd.ExcelWriter("States.xlsx",engine='xlsxwriter')
for i in st:
    States.append(i.text)
for j in States[0:10]:        #for testing only iam exported 10 states only
    driver.find_element_by_xpath("//option[contains(text(),'"+j+"')]").click()
    time.sleep(1)
    driver.find_element_by_xpath("//input[@value='Search']").click()
    dt=driver.find_elements_by_xpath("//tr[contains(@scope,'row')]")
    ListOfData= []
    for k in dt:
        ListOfData.append(k.text.split("  "))
    driver.back()
    df=pd.DataFrame(ListOfData,columns=["COMPANY_NAME","HEADQUATERS_LOCATION","COMPANY_TYPE","FLEET_SIZE"])
    df.to_excel(writer,sheet_name=j, index=False)
writer.save()
writer.close()
driver.close()