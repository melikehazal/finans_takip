# Kişisel Finans Takip Uygulaması

Bu proje, Flutter kullanılarak geliştirilen basit ve anlaşılır bir **kişisel finans takip uygulaması**dır.  
Amaç; bütçe, harcama ve kategori bazlı analiz kavramlarını mobil uygulama geliştirme pratiğiyle birleştirmektir.

Proje bir **öğrenme ve mimari deneme çalışması** olarak tamamlanmış, aktif geliştirme süreci bilinçli olarak sonlandırılmıştır.

---

## Uygulama Ne Yapar?
- Aylık bütçe tanımlama ve görüntüleme  
- Harcama ekleme ve toplam harcama takibi  
- Kalan bütçenin otomatik hesaplanması  
- Kategori bazlı harcama dağılımının grafiklerle gösterimi  

---

## Ekran Görüntüleri

<img src="assets/screenshots/home.png" width="250" />
<img src="assets/screenshots/add_expense.png" width="250" />
<img src="assets/screenshots/charts.png" width="250" />

---


## Teknik Detaylar
- **Flutter (Dart)**
- **Provider** ile state management
- **fl_chart** ile görselleştirme
- Katmanlı ve okunabilir dosya yapısı

> Local veri saklama için Hive entegrasyonu planlanmış ancak uygulanmamıştır.

---

## Proje Yapısı
```text
lib/
 ├─ models/
 ├─ providers/
 ├─ pages/
 └─ widgets/

---



