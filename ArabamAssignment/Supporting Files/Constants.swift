//
//  Constants.swift
//  ArabamAssignment
//
//  Created by Ferhat TOKER on 3.02.2021.
//

import Foundation

struct K {
    
    struct List {
        static let listTitle = "Araç İlan Listesi"
        static let listEmptyMessage = "Aradığınız kriterlerle eşleşen herhangi bir sonuç bulunamadı."
    }
    
    struct ListHeader {
        static let identifier = "ListHeader"
        
        static let beginning = "Aşağıdaki liste; "
        static let categoryId = "kategori numarası"
        static let minDate = "min ilan tarihi"
        static let maxDate = "max ilan tarihi"
        static let minYear = "min model yılı"
        static let maxYear = "max model yılı"
        static let filtered = " olacak şekilde filtrelenmiş ve "
        static let priceAscending = "fiyat, ucuzdan pahalıya doğru olacak şekilde sıralanmıştır."
        static let priceDescending = "fiyat, pahalıdan ucuza doğru olacak şekilde sıralanmıştır."
        static let dateAscending = "ilan tarihi, eskiden yeniye doğru olacak şekilde sıralanmıştır."
        static let dateDescending = "ilan tarihi, yeniden eskiye doğru olacak şekilde sıralanmıştır."
        static let yearAscending = "model yılı, eskiden yeniye doğru olacak şekilde sıralanmıştır."
        static let yearDescending = "model yılı, yeniden eskiye yeniye doğru olacak şekilde sıralanmıştır."
    }
    
    struct ListCell {
        static let identifier = "ListCell"
    }
    
    struct ListFooter {
        static let identifier = "ListFooter"
        
        static let loading = "Yükleniyor..."
    }
    
    struct FloatingActionView {
        static let sort = "Sırala"
        static let filter = "Filtrele"
    }
    
    struct BottomSheetSortView {
        
        static let sort = "⇵ Sırala"
        static let priceAscending = "Fiyat • Artan"
        static let priceDescending = "Fiyat • Azalan"
        static let dateAscending = "İlan tarihi • Artan"
        static let dateDescending = "İlan tarihi • Azalan"
        static let yearAscending = "Model yılı • Artan"
        static let yearDescending = "Model yılı • Azalan"
    }
    
    struct BottomSheetFilterView {
        static let filter = "⇄ Filtrele"
        static let categoryId = "Kategori Numarası"
        static let dateRangeTitle = "Tarih Aralığı"
        static let dateRangePlaceholder = "Minimum Tarih - Maksimum Tarih"
        static let clear = "Temizle"
        static let min = "Min"
        static let minDate = "En Eski"
        static let max = "Max"
        static let maxDate = "Bugün"
        static let modelYear = "Model Yılı"
        static let applyFilter = "Filtreyi Uygula"
        static let seperator = " - "
        
        static let allowedCharacters = "0123456789"
        static let allowedFirstDigits = "12"
    }
    
    struct ImageSize {
        static let size120x90 = "120x90"
        static let size160x120 = "160x120"
        static let size240x180 = "240x180"
        static let size580x435 = "580x435"
        static let size800x600 = "800x600"
        static let size1920x1080 = "1920x1080"
    }
    
    
    struct Detail {
        static let callOwner = "Araç sahibini ara..."
        static let call = "Ara"
        static let urlQueryScheme = "tel://"
    }
    
    struct DetailView {
        // Main Page
        static let vehicleDetails = "Araç Detayları"
        static let sellerDescriptions = "Satıcı Açıklamaları"
        
        // Vehicle Details Page
        static let categoryId = "Kategori Numarası"
        static let model = "Model"
        static let location = "Konum"
        static let price = "Fiyat"
        static let date = "İlan Tarihi"
        static let seller = "Satıcı"
        static let sellerContact = "Satıcı İletişim"
        
        // Seller Descriptions Page
        static let descriptionEmptyMessage = "Satıcı herhangi bir açıklama eklememiştir."
    }
    
    struct CustomColor {
        static let primaryColor  = "primaryColor"
        static let secondaryColor = "secondaryColor"
        static let labelColor = "labelColor"
    }
    
    struct AlertMessage {
        static let networkErrorTitle = "İnternet Bağlantısı Hatası"
        static let networkErrorMessage = "Görünüşe göre verileri yüklemekle alakalı bir sorun var. Lütfen internet bağlantınızı kontrol edin ve/veya uygulamayı tekrar başlatın."
        static let YearDigitsErrorTitle = "Hata"
        static let YearDigitsErrorMessage = "Yıl değeri 4 rakamdan oluşmalıdır."
        static let positiveTitle = "Tamam"
        static let negativeTitle = "İptal"
    }
}
