classdef binom
    %Класс для работы с биномами
    %Класс позволяет работать с биномами. Реализованы операции сложения,
    %вычитания, умножения, деления.
    properties (Access = private) % блок описания собственных полей, не доступных вне класса
        pol %объект многочлена
    end
    methods  (Access = public)     % общедоступные методы
        function this = binom(coefficients, pows)
            % конструктор. принимает массив коэффициентов и массив степеней
            if nargin == 0 
                this.pol = polynom();
            elseif nargin == 1
                if isa(coefficients, 'polynom')
                    this.pol = coefficients;
                elseif isa(coefficients, 'binom')
                    this = coefficients;
                else
                    this.pol = polynom(coefficients);
                end
            elseif length(coefficients)~=2 || length(pows)~=2
                this.pol = polynom();
            else
                coefs=[];
                coefs(pows(1)+1)=coefficients(1);
                coefs(pows(2)+1)=coefficients(2);
                this.pol = polynom(fliplr(coefs));
            end
        end
        function result = plus(b1,b2)
            %сложение биномов
            res = b1.pol+b2.pol;
            if ~res.isBinom()
                error('Результат не является биномом.')
            else
                result=binom(res);
            end
        end
        function result = minus(b1,b2)
            %вычитание биномов
            res = b1.pol-b2.pol;
            if ~res.isBinom()
                error('Результат не является биномом.')
            else
                result=binom(res);
            end
        end
        function result = mtimes(b1,b2)
            %умножение биномов
            res = b1.pol*b2.pol;
            if ~res.isBinom()
                error('Результат не является биномом.')
            else
                result=binom(res);
            end
        end
        function result = mpower(b,pow)
            %возведение в степень биномов
            res = b.pol^pow;
            if ~res.isBinom()
                error('Результат не является биномом.')
            else
                result=binom(res);
            end
        end
        function result = mrdivide(b1,b2)
            %деление биномов. остаток отбрасываем
            res = b1.pol/b2.pol;
            if ~res.isBinom()
                error('Результат не является биномом.')
            else
                result=binom(res);
            end
        end
        function display(b)
            %отображение
            b.pol.display();
        end
        function s = toString(b)
            % формирует строковое представление для бинома
            s = b.pol.toString();
        end
    end
end