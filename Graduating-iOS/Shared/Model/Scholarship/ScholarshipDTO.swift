//  Author: hhhello0507
//  Created: 10/11/24


import Foundation

public struct Scholarship: ModelProtocol {
    public let id: Int
    
    /// 모집시작일
    public let recruitmentStartDate: Date?
    
    /// 모집종료일
    public let recruitmentEndDate: Date?
    
    /// 상품명
    public let productName: String
    
    /// 선발방법 상세내용
    public let selectionMethodDetails: String?
    
    /// 선발인원 상세내용
    public let selectionNumberDetails: String?
    
    /// 성적기준 상세내용
    public let gradeCriteriaDetails: String?
    
    /// 소득기준 상세내용
    public let incomeCriteriaDetails: String?
    
    /// 운영기관구분
    public let operatingInstitutionCategory: OperatingInstitutionCategory
    
    /// 운영기관명
    public let operatingInstitutionName: String
    
    /// 자격제한 상세내용
    public let qualificationRestrictionsDetails: String?
    
    /// 제출서류 상세내용
    public let requiredDocumentsDetails: String?
    
    /// 지역거주여부 상세내용
    public let residencyDetails: String?
    
    /// 지원내역 상세내용
    public let supportDetails: String?
    
    /// 추천필요여부 상세내용
    public let recommendationRequiredDetails: String?
    
    /// 특정자격 상세내용
    public let specificQualificationDetails: String?
    
    /// 학교구분
    public let schoolCategory: [String]
    
    /// 학년구분
    public let gradeLevel: [String]
    
    /// 학자금유형구분
    public let financialAidType: FinancialAidType
    
    /// 홈페이지주소
    public let homepageUrl: String
    
    public enum OperatingInstitutionCategory: String, ModelProtocol {
        case localGovernment = "LOCAL_GOVERNMENT"
        case privateCorporation = "PRIVATE_CORPORATION"
        case privateOther = "PRIVATE_OTHER"
        case relatedMinistries = "RELATED_MINISTRIES"
        case kosaf = "KOSAF"
        case university = "UNIVERSITY"
        
        public var korean: String {
            switch self {
            case .localGovernment:
                "지자체"
            case .privateCorporation:
                "민간(기업)"
            case .privateOther:
                "민간(기타)"
            case .relatedMinistries:
                "관계부처"
            case .kosaf:
                "한국장학재단"
            case .university:
                "대학교"
            }
        }
    }
    
    public enum FinancialAidType: String, ModelProtocol {
        case local = "LOCAL"
        case special = "SPECIAL"
        case incomeClassification = "INCOME_CLASSIFICATION"
        case goodScore = "GOOD_SCORE"
        case other = "OTHER"
        case disabled = "DISABLED"
        
        public var korean: String {
            switch self {
            case .local:
                "지역연고"
            case .special:
                "특기자"
            case .incomeClassification:
                "소득구분"
            case .goodScore:
                "성적우수"
            case .other:
                "기타"
            case .disabled:
                "장애인"
            }
        }
    }
}
