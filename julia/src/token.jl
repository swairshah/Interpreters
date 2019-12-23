export TokenType
export Token

struct TokenType
    name::Symbol
end

struct Token
    type::TokenType
    literal::String
end


