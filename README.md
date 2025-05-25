# Fake-Store--SwiftUI
Bu proje bir iOS app porjesidir.SwiftUI ile geliştirilmiştir. Uygulama aşağıdaki verilen API servis sağlayıcısı dikeyinde bir E-Ticaret uygulaması klonudur.
**Kullanılan API Service** : Platzi Fake Store Api "https://fakeapi.platzi.com/en/about/introduction/"

Uygulamanın UI tasarımına özenilmemiştir. Belirli bir tasarım kullanılmamıştır. Bu uygulamanın amacı Swift - SwiftUI yetkinliklerimi artırmaktır.
Uygulamanın katmanlı bir klasör yapısı mevcuttur.
Data/..
Features/..
Utilities/..

**Data**
Data klasörünün altında modeller ve servisler yer almaktadır.
**Modeller**
ProfileResponseModel : Kullanıcının profil detaylarını içerir.
RefreshAccessToken(Response/Request)Model : Kullanıcı tokenlarını yenileme işlemlerinde kullanılan alanları içerirler.
SigIn(Response/Request)Model : Kullanıcı giriş işlemleri için kullanılan modellerdir.
SignUp(Response/Request)Model : Kullanıcı kayıt işlemleri için kullanılan modellerdir. 
ErrorModel : Hataları yönetmek için kullanılan modeldir.
Product: Ürün ve detaylarını içeren modeldir.

**Servisler**
Servisler Api ve Local olarak ikiye ayrılmıştır.

**Local**
KeychainService: Kullanıcının token bilgilerini saklamak için oluşturulmuş bir singleton sınıftır.AuthKey enum'ı ile anahtar kelimeler enum'da toplanmıştır.

**Api**
NetworkService :
Network işlemleri için Alamofire paketi kullanılmıştır. NetworkService sınıfı singleton hale getirilmiştir. Gizli bir baseUrl değişkeni ile  ana url korunmuştur.
Ana bir "request" fonksiyonu ile isteklerin ana yapısı belirlenmiştir.
-request Fonksiyonu-

```
func request<T: Decodable, P: Encodable>(endPoint: String,method: HTTPMethod = .get, parameters: P? = nil, headers: HTTPHeaders? = nil) async throws -> T {   
        
        let url = baseURL + endPoint
       
          
            let dataRequest =  AF.request(url, method: method,parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<299)
        
        let response  =  await dataRequest.serializingDecodable(T.self).response
       
        switch response.result {
        case .success(let data):
            return data
        case .failure(_):
            if let data = response.data {
                throw ErrorModel(title: "Network Error", message: String(data: data, encoding: .utf8) ?? "", statusCode:response.response?.statusCode)
                }
            throw ErrorModel(title: "Network Error", message: "Something Went Wrong",statusCode: response.response?.statusCode)
            }
        }
    
    func request<T: Decodable>(
            endPoint: String,
            method: HTTPMethod = .get,
            headers: HTTPHeaders? = nil
        ) async throws -> T {

            let url = baseURL + endPoint
            
            let dataRequest =  AF.request(url, method: method, headers: headers)
                .validate(statusCode: 200..<299)
         
            let response  =  await dataRequest.serializingDecodable(T.self).response
        
            switch response.result {
            case .success(let data):
                return data
            case .failure(_):
                 if let data = response.data {
                     throw ErrorModel(title: "Network Error", message: String(data: data, encoding: .utf8) ?? "Unknown error format", statusCode:response.response?.statusCode)
                 }

                 throw ErrorModel(title: "Network Error", message: "Something Went Wrong", statusCode: response.response?.statusCode)
            }
        }
```

AuthorizationService : Kullanıcının giriş-kayıt vs. yetkilendirme işlemleri için oluşturulmuş bir sınıftır. NetworkService ve KeychainService nesneleri alır. EndPoint enum ı ile okunabilirlik artırılmaya çalışılmıştır.Kullanıcı giriş için network isteği yollanır ve kullanıcı access ve refresh tokenları keychain kaydedilir.
Kullanıcı kayıt için network isteği yollanır ve kullanıcı kayıt edilir. Kullanıcının profile detaylarını almak için KeychainService ile token alınır servise istek atılır  ve profile detayları alınır.

Devam Edecek...


 

  




<img src="https://github.com/user-attachments/assets/dad469f0-37ab-4787-a8c2-7f420a804c3e" width="300" alt="Fake Store - Splash Ekranı">
<img src="https://github.com/user-attachments/assets/dd972a95-a157-4813-a382-7535d8ad3b9f" width="300" alt="Fake Store - Login Ekranı">
<img src="https://github.com/user-attachments/assets/36f1f702-a766-488b-9a5e-747289817933" width="300" alt="Fake Store - Ürün Listesi">
<img src="https://github.com/user-attachments/assets/bf8ce107-7bb9-4d7e-a11f-645a7a8a2da8" width="300" alt="Fake Store - Ürün Detayı">
