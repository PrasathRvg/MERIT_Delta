import pandas as pd
import selenium
from selenium import webdriver 
import time
writer=pd.ExcelWriter("Amazon_1.xlsx",engine='xlsxwriter')
driver= webdriver.Chrome(executable_path=r"C:\Users\Merit\Downloads\chromedriver_win32\chromedriver.exe")
driver.get("https://www.amazon.in/s?bbn=5689464031&rh=n%3A1380441031%2Cn%3A5689444031%2Cn%3A5689464031%2Cp_n_format_browse-bin%3A19560798031&pf_rd_i=15390366031&pf_rd_i=15390366031&pf_rd_m=A1K21FY43GMZF8&pf_rd_m=A1K21FY43GMZF8&pf_rd_p=23ebb46d-920d-4ffc-915b-02e8814181cb&pf_rd_p=803ecbd5-6198-46c7-93cd-86943ae17d20&pf_rd_r=B9JS18CXP56WF79V8SM2&pf_rd_r=RWJB2TVD5ST3GJ14E3AP&pf_rd_s=merchandised-search-7&pf_rd_s=merchandised-search-9&pf_rd_t=101&pf_rd_t=101&ref=s9_acss_bw_cg_pbfurn4_3b1_w")
no=0;
try:
    while True:
        ProductNames=[]
        OfferPrice=[]
        OriginalPrice=[]
        time.sleep(2)
        if no>0:
            driver.find_element_by_xpath("//li[@class='a-last']").click()
        time.sleep(2)
        Prod_Names=driver.find_elements_by_xpath("//h2[@class='a-size-mini a-spacing-none a-color-base s-line-clamp-4']")
        for i in Prod_Names:
            ProductNames.append(i.text)
        Off_Pric=driver.find_elements_by_xpath("//span[@class='a-price']")
        for j in Off_Pric:
            OfferPrice.append(j.text)
        Orig_price=driver.find_elements_by_xpath("//span[@class='a-price a-text-price']")
        for k in Orig_price:
            OriginalPrice.append(k.text)
        df=pd.DataFrame(list(zip(ProductNames,OfferPrice,OriginalPrice)),columns=['product_name','Offer_Price','Original_Price'])
        df.to_excel(writer,sheet_name="page"+str(no+1), index=False)
        no=no+1;

except:
    writer.save()
    writer.close()
    driver.close()