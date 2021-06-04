import Foundation

// MARK: - Enum for validating Text Fields
enum InputType {
    // case of Banking Billet
    case name
    case cpf
    case phone_number
    case email
    case street
    case number
    case neighborhood
    case zipcode
    case city
    case complement
    case state
    case corporate_name
    case cnpj
    
    // case of Items
    case value
    
    // case of Additional Fields
    case date
    case shipping
    case typeOf_discount
    case discount
    case typeOf_conditional_discount
    case conditional_discount
    case until_date
    case message
    
    case buttonNotEnable
}

// MARK: - Enum for validating group of fields according to API required
enum FieldsType{
    // case of Banking Billet
    case binding
    case juridicalPerson
    case addedFields
    case buttonNotEnable
    
    // case of Addtional Fields
    case date
    case addFields
}
