# CoreData
 Swift programlama dilinde Core Data, Apple’ın sağladığı bir kalıcı veri yönetim (persistent data management) framework’üdür. Core Data, iOS, macOS, watchOS ve tvOS uygulamalarında verileri saklamak, yönetmek ve almak için kullanılır.

Core Data Ne İşe Yarar?
Veri Saklama: Kullanıcının verilerini cihazda saklar (örneğin, notlar, ayarlar, favori öğeler).
İlişkisel Veri Modeli: Veriler arasında ilişkiler kurmanıza olanak tanır (örneğin, bir kullanıcının birden fazla siparişi olabilir).
Otomatik Senkronizasyon: iCloud ile entegre edilerek verilerin cihazlar arasında senkronize edilmesini sağlayabilir.
Bellek Yönetimi: Sadece ihtiyacınız olan veriyi belleğe yükler, böylece performansı optimize eder.
Veri Filtreleme ve Sıralama: SQL benzeri sorgular ile verileri filtreleyebilir ve sıralayabilirsiniz.

Core Data’nın Avantajları
Verimli Veri Yönetimi: Büyük veri setlerini yönetirken bellek kullanımını optimize eder.
Karmaşık Veri Modelleri Destekler: Veri modelleri arasında One-to-One, One-to-Many, Many-to-Many ilişkilerini yönetebilir.
NSFetchedResultsController ile Kolay UI Entegrasyonu: Değişiklikleri otomatik olarak takip eder ve UI güncellenir.
iCloud ile Entegrasyon: Verileri cihazlar arasında senkronize edebilir.

Core Data Alternatifleri
UserDefaults: Küçük miktarda veri saklamak için uygundur (tercihler, ayarlar vb.).
File System (Plist, JSON, CSV): Daha basit veri saklama gereksinimleri için kullanılabilir.
SQLite: Core Data’nın altında yatan teknolojidir, ancak manuel SQL kullanımı gerektirir.
Realm, Firebase: Alternatif olarak kullanılabilecek üçüncü taraf veri saklama çözümleridir.
