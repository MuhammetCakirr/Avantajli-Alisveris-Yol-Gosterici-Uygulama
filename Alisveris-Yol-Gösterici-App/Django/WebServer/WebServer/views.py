import threading
from bs4 import BeautifulSoup
from django.http import HttpResponse, JsonResponse
import requests
import json
from selenium.webdriver.common.keys import Keys
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome import service
import time
from selenium.webdriver.common.action_chains import ActionChains
import asyncio
from PIL import Image
from io import BytesIO
from django.views.decorators.csrf import csrf_exempt

#python manage.py runserver 192.168.1.114:8000


def home_page(request):
    homepageveriler=[]
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--start-maximized")
    chrome_options.add_experimental_option("prefs", {"profile.default_content_setting_values.notifications": 2}) 
    url = 'https://www.cimri.com'
    driver = webdriver.Chrome(options=chrome_options)
    driver.get(url)
    timeout = 10
    try:
        cookie_notification_button = WebDriverWait(driver, timeout).until(
        EC.presence_of_element_located((By.CSS_SELECTOR, '.onetrust-close-btn-handler'))
        )
        cookie_notification_button.click()
    except Exception as e:
        print("Çerez bildirimi butonu bulunamadı veya tıklanamadı:", str(e))
    swipers = driver.find_elements(By.CLASS_NAME, "swiper-scrollbar-drag")
    sayac = 0
    for swiper in swipers:   
        donus = 0
        if sayac == 0 or sayac == 8:
            while True:
                sayfa_kaynagi = driver.page_source
                soup = BeautifulSoup(sayfa_kaynagi, "html.parser")   
                if donus >= 8:
                    break
                else:
                    if donus >= 7:
                        break    
                action = ActionChains(driver)
                action.click_and_hold(swiper).move_by_offset(120, 0).release().perform()
                donus = donus + 1        

        sayac = sayac + 1    
    driver.quit()
    indirimliUrunler=soup.find_all("section")[0]
    indirimliUrunlerdiv=indirimliUrunler.find_all("article")
    for indirimli in indirimliUrunlerdiv:
        
        urun_id_div=indirimli.find("a",class_="ProductCard_link__T1uwx")
        urun_id="https://www.cimri.com"+urun_id_div.get("href")

        urun_ad_div = indirimli.find("div", class_="ProductCard_title__RQSVg")
        urun_ad = urun_ad_div.text.strip() if urun_ad_div else "Bilinmiyor"


        urun_resmi_div = indirimli.find("div", class_="ProductCard_card_image__DyUV2")
        urun_resmi = urun_resmi_div.find("img")["src"] if urun_resmi_div and urun_resmi_div.find("img") else "Bilinmiyor"

        indirim_orani_div = indirimli.find("span", class_="Badge_percentage__UIvd3")
        indirim_orani = indirim_orani_div.text.strip() if indirim_orani_div else "Bilinmiyor"

        fiyat_div = indirimli.find("div", class_="ProductPrice_price__Dky8g")
        fiyat = fiyat_div.find("span", class_="ProductPrice_priceValue__jRH_T").text.strip() if fiyat_div else "Bilinmiyor"
        eski_fiyat = fiyat_div.find("span", class_="ProductPrice_oldPriceValue__7bdzS").text.strip() if fiyat_div.find("span", class_="ProductPrice_oldPriceValue__7bdzS") else "Bilinmiyor"

        satici_div = indirimli.find("div", class_="ProductPrice_merchantName__zjZoL")
        satici_magaza = satici_div.text.strip() if satici_div else "Bilinmiyor"

        ucuz_fiyat_div = indirimli.find("div", class_="ProductDiscount_label__wE7vj")
        ucuz_fiyat = ucuz_fiyat_div.text.strip() if ucuz_fiyat_div else "Bilinmiyor"

        bugun_basladi_div = indirimli.find("div", class_="ProductDiscount_label__wE7vj", string="Bugün başladı")
        bugun_basladi = "Evet" if bugun_basladi_div else "Hayır"


        incele_buton = indirimli.find("a", class_="Button_button__JSk9m").text.strip()
        print("Indirimli Urun id:", urun_id)
        print("Indirimli Urun Adi:", urun_ad)
        print("Indirimli Urun Resmi:", urun_resmi)
        print("Indirim Orani:", indirim_orani)
        print("Indirimli Fiyat:", fiyat)
        print("Indirimli Eski Fiyat:", eski_fiyat)
        print("Indirimli Satici Magaza:", satici_magaza)
        print("Indirimli Son 30 gunun en ucuzu:", ucuz_fiyat)
        print("Indirimli Bugün başladi:", bugun_basladi)
        print("Indirimli Incele Butonu:", incele_buton)
        print("\n")
        urun={
             "Type":"ProductA",
            "Indirimli Urun id":urun_id,
            "Indirimli Urun Adi":urun_ad,
            "Indirimli Urun Resmi":urun_resmi,
            "Indirim Orani":indirim_orani,
            "Indirimli Fiyat":fiyat,
            "Indirimli Eski Fiyat":eski_fiyat,
            "Indirimli Satici Magaza":satici_magaza,
            "Indirimli Son 30 gunun en ucuzu":ucuz_fiyat,
            "Indirimli Bugun basladi":bugun_basladi,
            "Indirimli Incele Butonu":incele_buton
        }
        homepageveriler.append(urun)
        
    EncokTakipEdilenUrunler=soup.find_all("section")[7]
    EncokTakipEdilenUrunlerdiv=EncokTakipEdilenUrunler.find_all("article")
    for takipedilen in EncokTakipEdilenUrunlerdiv:

        urun_id_div=takipedilen.find("a",class_="ProductCard_link__T1uwx")
        takipedilenurun_id="https://www.cimri.com"+urun_id_div.get("href")

        urun_ad_div = takipedilen.find("div", class_="ProductCard_title__RQSVg")
        takipedilenurun_ad = urun_ad_div.text.strip() if urun_ad_div else "Bilinmiyor"

        urun_resmi_div = takipedilen.find("div", class_="ProductCard_card_image__DyUV2")
        takipedilenurun_resmi = urun_resmi_div.find("img")["src"] if urun_resmi_div and urun_resmi_div.find("img") else "Bilinmiyor"

        a_elements = takipedilen.find("div", class_="ProductCard_card_body__A00tX").find_all("a")

        takipedilenbirinci_magaza = a_elements[0].text.strip() if len(a_elements) > 0 else " "
        takipedilenikinci_magaza = a_elements[1].text.strip() if len(a_elements) > 1 else " "
        duzeltilmis_metin = takipedilenbirinci_magaza.replace("EN UCUZ", "")

        if duzeltilmis_metin.__contains__(".tr"):
                yenimetin=duzeltilmis_metin.replace(".tr", "")
                parcalar = yenimetin.split(".com")
                magaza1 = parcalar[0]+".com"
                fiyat1 = parcalar[1]  
        else:
                if duzeltilmis_metin.__contains__(".com"):
                    parcalar = duzeltilmis_metin.split(".com")
                    magaza1 = parcalar[0]+".com"
                    fiyat1 = parcalar[1]  
                else:    
                    magaza1="Bulunamadı"
                    fiyat1="Bulunamadı"     
                     
        if takipedilenikinci_magaza.__contains__(".tr"):
                yenimetin=takipedilenikinci_magaza.replace(".tr", "")
                parcalar = yenimetin.split(".com")
                magaza2 = parcalar[0]+".com"
                fiyat2 = parcalar[1]
        else:
                if takipedilenikinci_magaza.__contains__(".com"):
                    parcalar = takipedilenikinci_magaza.split(".com")
                    magaza2 = parcalar[0]+".com"
                    fiyat2 = parcalar[1]
                else:    
                    magaza2="Bulunamadı"
                    fiyat2="Bulunamadı"  

        takipedilenincele_buton = takipedilen.find("a", class_="Button_button__JSk9m").text.strip()

        print("Ürün id:", takipedilenurun_id)
        print("Ürün Adı:", takipedilenurun_ad)
        print("Ürün Resmi:", takipedilenurun_resmi) 
        print("birincimagaza:", takipedilenbirinci_magaza)
        print("ikincimagaza:", takipedilenikinci_magaza)
        print("İncele Butonu:", takipedilenincele_buton)
        print("\n")
        takipedilenurun = {
        "Type":"ProductB",
        "Takip Urun id": takipedilenurun_id,
        "Takip Urun Adi": takipedilenurun_ad,
        "Takip Urun Resim":takipedilenurun_resmi,
        "Takip Birinci Magaza":magaza1 if magaza1 else "",
        "Takip Fiyat 1":fiyat1,
        "Takip Ikinci Magaza":magaza2 if magaza2 else "",
        "Takip Fiyat 2":fiyat2,
        "Takip incele Butonu":takipedilenincele_buton
                }
        homepageveriler.append(takipedilenurun)
        response_data = {'Urunler': homepageveriler}
    return JsonResponse(response_data)  
   
def home(request):
    return JsonResponse({'message': 'Welcome to the Example App!'})
@csrf_exempt
def SearchPage(request):
    if request.method == 'POST':    
        veri = request.POST.get('veri', '')
        url = veri
        url = 'https://www.cimri.com/arama?q='+veri
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
        urunler = soup.find_all("article")
        veriler = []
        for urun in urunler:
            try:
                urun_id="https://www.cimri.com"+urun.find("a",class_="link-detail").get("href") 
                #ad = urun.h3.text.strip() 
                h3_element = urun.h3
                if h3_element:
                    ad = h3_element.text.strip()
                else:
                    ad = "Bilinmiyor"
                resim_url = urun.find("img", class_="s51lp5-0 cRlUpX")["data-src"] 
                a_elements = urun.find("div", class_="top-offers").find_all("a")
                birinci_magaza = a_elements[0].text.strip() if len(a_elements) > 1 else "Bos"
                ikinci_magaza = a_elements[1].text.strip() if len(a_elements) > 1 else "Bos"
                resim_url2="https:"+resim_url
                if birinci_magaza.__contains__(".tr"):
                    yenimetin=birinci_magaza.replace(".tr", "")
                    parcalar = yenimetin.split(".com")
                    magaza1 = parcalar[0]+".com"
                    fiyat1 = parcalar[1]  
                else:
                    if birinci_magaza.__contains__(".com"):
                        parcalar = birinci_magaza.split(".com")
                        magaza1 = parcalar[0]+".com"
                        fiyat1 = parcalar[1]  
                    else:    
                        magaza1="Bulunamadı"
                        fiyat1="Bulunamadı"

                if ikinci_magaza.__contains__(".tr"):
                    yenimetin=ikinci_magaza.replace(".tr", "")
                    parcalar = yenimetin.split(".com")
                    magaza2 = parcalar[0]+".com"
                    fiyat2 = parcalar[1]
                else:
                    if ikinci_magaza.__contains__(".com"):
                        parcalar = ikinci_magaza.split(".com")
                        magaza2 = parcalar[0]+".com"
                        fiyat2 = parcalar[1]
                    else:    
                        magaza2="Bulunamadı"
                        fiyat2="Bulunamadı"        
                print("Telefon id:", urun_id)
                print("Telefon Adı:", ad)
                print("Resim URL:", resim_url2)
                print("Birinci Mağaza:", magaza1)
                print("Fiyat 1:", fiyat1)
                print("İkinci Mağaza:",magaza2)
                print("Fiyat 2:", fiyat2)
                print("\n")
                veri = {
        "Takip Urun id": urun_id if urun_id else "Bos",
        "Takip Urun Adi":ad if ad else "Bos",
        "Takip Urun Resim":resim_url if resim_url else "https://cdn.cimri.io/image/178x178/xiaomi-redmi-note-12-pro-5g-256gb-8gb-ram-mavi_663967144.jpg",
        "Takip Birinci Magaza":magaza1 if magaza1 else "Bos",
        "Takip Fiyat 1":fiyat1 if fiyat1 else "Bos",
        "Takip Ikinci Magaza": magaza2 if magaza2 else "Bos",
        "Takip Fiyat 2":fiyat2 if fiyat2 else "Bos",
        "Takip incele Butonu": "Bos"
                }
                veriler.append(veri)
                response_data = {'Bilgiler': veriler}
            except Exception as e:
                print(f"Hata oluştu: {str(e)}")
        print("VERİLER LENGHT:",len(veriler))
        return JsonResponse(response_data)             

@csrf_exempt       
def ProductDetailPage(request):
    if request.method == 'POST':
        veri = request.POST.get('veri', '')
        url = veri
        urunbilgiler=[]
        
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
    
        fotografdiv=soup.find("div",class_="s98wa6g-1")
        fotograflar=fotografdiv.find_all("li",class_="s1wxq1uo-2")
    
        urunfotograf=fotograflar[0].img["src"]
        urunfotograf2="https:"+urunfotograf
    
        urunAd=soup.find("h1",class_="s1wytv2f-2 jTAVuj").text
        enucuzmagaza=soup.find("span",class_="s1wl91l5-2 dWTGzr").text
        enucuzmagazafiyat=soup.find("span",class_="s1wl91l5-4 cBVHJG").text
        kacmagazavar=soup.find("div",class_="s16d8slc-1 dQHrnM").text
        temiz_metin2 = enucuzmagazafiyat.replace(" TL", "")
        magazalargeneldiv=soup.find("div",class_="s17f9cy4-1 ICGpp")
        magazalardiv=soup.find_all("div",class_="s17f9cy4-19 heJchT")
        print(len(magazalardiv))
        print("Urun Fotografı:",urunfotograf2)
        print("Urun Adı:",urunAd)
        print("En Ucuz Magaza:",enucuzmagaza)
        print("En Ucuz Magaza Fiyat:",enucuzmagazafiyat)
        print("Kaç magaza var:",kacmagazavar)
        print("\n")
        for magaza in magazalardiv:
            magazafotodiv=magaza.find("div",class_="s17f9cy4-23")
            img_element = magazafotodiv.find("img", class_="s17f9cy4-24")
            if img_element:
                magazafoto = img_element["src"]
            else:
                magazafoto = "Bilinmiyor"
            urunaddiv=magaza.find("div",class_="s17f9cy4-26 dcOLtu")
            magazaurunad=urunaddiv.find("span",class_="s17f9cy4-30 ktuqLd").text.strip()
            magazafiyatdiv=magaza.find("div",class_="s17f9cy4-28 kRTMjc")
            magazafiyat=magazafiyatdiv.find("div",class_="s17f9cy4-11 gkkxYN").text.strip()
            temiz_metin = magazafiyat.replace(",", "").replace(" TL", "")
            temiz_metin2 = magazafiyat.replace(" TL", "")
            guncellemetarihi=magazafiyatdiv.find("div",class_="s17f9cy4-14 djAVeM").text.strip()

            print("magazafoto:",magazafoto)
            print("magazaurunad:",magazaurunad)
            print("magazafiyat:",temiz_metin)
            print("guncellemetarihi:",guncellemetarihi)
            print("\n")
            veri={
              "Urun Fotografi":urunfotograf2,
              "Urun Adi":urunAd,
              "En Ucuz Magaza":enucuzmagaza,
              "En Ucuz Magaza Fiyat":temiz_metin2,
              "Kac magaza var":kacmagazavar,
              "magazafoto":magazafoto,
              "magazaurunad":magazaurunad,
              "magazafiyat":temiz_metin,
              "magazafiyat2":temiz_metin2,
              "guncellemetarihi":guncellemetarihi
            }
            urunbilgiler.append(veri)
            response_data = {'Bilgiler': urunbilgiler}
        return JsonResponse(response_data) 
@csrf_exempt   
def SelectedProductPage(request):
    if request.method == 'POST':    
        veri = request.POST.get('veri', '')
        url = veri
        url = 'https://www.cimri.com'+veri
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
        urunler = soup.find_all("article")
        veriler = []
        
        for urun in urunler:
            try:    
                urun_id="https://www.cimri.com"+urun.find("a",class_="link-detail").get("href") 
                #ad = urun.h3.text.strip() 
                h3_element = urun.h3
                if h3_element:
                    ad = h3_element.text.strip()
                else:
                    ad = "Bilinmiyor"
                resim_url = urun.find("img", class_="s51lp5-0 cRlUpX")["data-src"] 
                a_elements = urun.find("div", class_="top-offers").find_all("a")
                birinci_magaza = a_elements[0].text.strip() if len(a_elements) > 1 else "Bos"
                ikinci_magaza = a_elements[1].text.strip() if len(a_elements) > 1 else "Bos"
                resim_url2="https:"+resim_url
                if birinci_magaza.__contains__(".tr"):
                    yenimetin=birinci_magaza.replace(".tr", "")
                    parcalar = yenimetin.split(".com")
                    magaza1 = parcalar[0]+".com"
                    fiyat1 = parcalar[1]  
                else:
                    if birinci_magaza.__contains__(".com"):
                        parcalar = birinci_magaza.split(".com")
                        magaza1 = parcalar[0]+".com"
                        fiyat1 = parcalar[1]  
                    else:    
                        magaza1="Bulunamadı"
                        fiyat1="Bulunamadı"

                if ikinci_magaza.__contains__(".tr"):
                    yenimetin=ikinci_magaza.replace(".tr", "")
                    parcalar = yenimetin.split(".com")
                    magaza2 = parcalar[0]+".com"
                    fiyat2 = parcalar[1]
                else:
                    if ikinci_magaza.__contains__(".com"):
                        parcalar = ikinci_magaza.split(".com")
                        magaza2 = parcalar[0]+".com"
                        fiyat2 = parcalar[1]
                    else:    
                        magaza2="Bulunamadı"
                        fiyat2="Bulunamadı"        
                print("Telefon id:", urun_id)
                print("Telefon Adı:", ad)
                print("Resim URL:", resim_url2)
                print("Birinci Mağaza:", magaza1)
                print("Fiyat 1:", fiyat1)
                print("İkinci Mağaza:",magaza2)
                print("Fiyat 2:", fiyat2)
                print("\n")
                veri = {
        "Takip Urun id": urun_id if urun_id else "Bos",
        "Takip Urun Adi":ad if ad else "Bos",
        "Takip Urun Resim":resim_url if resim_url else "https://cdn.cimri.io/image/178x178/xiaomi-redmi-note-12-pro-5g-256gb-8gb-ram-mavi_663967144.jpg",
        "Takip Birinci Magaza":magaza1 if magaza1 else "Bos",
        "Takip Fiyat 1":fiyat1 if fiyat1 else "Bos",
        "Takip Ikinci Magaza": magaza2 if magaza2 else "Bos",
        "Takip Fiyat 2":fiyat2 if fiyat2 else "Bos",
        "Takip incele Butonu": "Bos"
                }
                veriler.append(veri)
                response_data = {'Bilgiler': veriler}
            except Exception as e:
                print(f"Hata oluştu: {str(e)}")    
        
        print("VERİLER LENGHT:",len(veriler))
        return JsonResponse(response_data)
       
            
       




                                                     



