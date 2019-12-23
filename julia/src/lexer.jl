include("token.jl")

const input = "=;+(){}"

t = Token(TokenType(:ASSIGN), "=")
println(t)

mutable struct Lexer 
    input::String
    position::Int
    readPoistion::Int
    ch::Char
end

function New(input::String)::Lexer
    l = Lexer(input, 1, 2, input[1])
    return l
end

function readChar(l::Lexer) 
    if l.readPoistion > length(l.input) 
        l.ch = '\0'
    else
        l.ch = l.input[l.readPoistion]
    end

    l.position = l.readPoistion
    l.readPoistion += 1
    l
end

newToken(tokType::TokenType,ch::Char) :: Token = Token(tokType,string(ch))
newToken(tokSymb::Symbol,ch::Char) :: Token = Token(TokenType(tokSymb), string(ch))
newToken(tokType::TokenType, str::String) :: Token = Token(tokType, str)
newToken(tokSymb::Symbol, str::String) :: Token = Token(TokenType(tokSymb), str)

function NextToken(l::Lexer) :: Token
    if l.ch == '='
        tok = newToken(:ASSIGN, l.ch)
    elseif l.ch == ';'
        tok = newToken(:SEMICOLON, l.ch)
    elseif l.ch == '+'
        tok = newToken(:PLUS, l.ch)
    elseif l.ch == '('
        tok = newToken(:LPAREN, l.ch)
    elseif l.ch == ')'
        tok = newToken(:RPAREN, l.ch)
    elseif l.ch == '{'
        tok = newToken(:LBRACE, l.ch)
    elseif l.ch == '}'
        tok = newToken(:RBRACE, l.ch)
    elseif l.ch == ','
        tok = newToken(:COMMA, l.ch)
    elseif l.ch == '\0'
        tok = newToken(:EOF, "")
    end
    readChar(l)

    tok
end
