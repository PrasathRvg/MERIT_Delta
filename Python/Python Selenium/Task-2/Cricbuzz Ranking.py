driver= webdriver.Chrome(executable_path=r"C:\Users\Merit\Downloads\chromedriver_win32\chromedriver.exe")
driver.get("https://www.cricbuzz.com/")
driver.maximize_window()
driver.find_element_by_xpath("//div[@id='rankingDropDown']").click()
lst_types=['batsmen','bowlers','all-rounders','teams']
lst_mat_types=['TEST','ODI','T20']
for i in lst_types:
    writer=pd.ExcelWriter(" "+i+".xlsx",engine='xlsxwriter')
    driver.find_element_by_xpath("//a[@id='"+i+"-tab']").click()
    driver.implicitly_wait(2)
    for j in lst_mat_types:
        if i=="teams":
            driver.find_element_by_link_text(j).click()
            country = driver.find_elements_by_xpath("//div[contains(@class,'cb-col cb-col-100 cb-font-14 cb-brdr-thin-btm text-center')]")
            ListOfData= []
            for k in country:
                if k.text !='':
                    ListOfData.append(k.text.split("\n"))
            df=pd.DataFrame(ListOfData,columns=["POSITION","TEAM","RATING","POINTS"])
            df.to_excel(writer,sheet_name=i+"_"+j, index=False)
            print(df)
            continue
        else:
            driver.find_element_by_link_text(j).click()
            country = driver.find_elements_by_xpath("//a[@id='"+i.replace('-','')+"-tests-tab']//following::div[contains(@class,'cb-col cb-col-100 cb-font-14 cb-lst-itm text-center')]")
        ListOfData= []
        for k in country:
            if k.text !='':
                ListOfData.append(k.text.split("\n"))
        df=pd.DataFrame(ListOfData,columns=["position","NAN","PLAYER","COUNTRY","RATING"])
        df.drop(columns=["NAN"],axis="columns",inplace=True)
        df.to_excel(writer,sheet_name=i+"_"+j, index=False)
        print(df)
writer.save()
writer.close()
driver.close()