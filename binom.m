classdef binom
    %����� ��� ������ � ��������
    %����� ��������� �������� � ��������. ����������� �������� ��������,
    %���������, ���������, �������.
    properties (Access = private) % ���� �������� ����������� �����, �� ��������� ��� ������
        pol %������ ����������
    end
    methods  (Access = public)     % ������������� ������
        function this = binom(coefficients, pows)
            % �����������. ��������� ������ ������������� � ������ ��������
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
            %�������� �������
            res = b1.pol+b2.pol;
            if ~res.isBinom()
                error('��������� �� �������� �������.')
            else
                result=binom(res);
            end
        end
        function result = minus(b1,b2)
            %��������� �������
            res = b1.pol-b2.pol;
            if ~res.isBinom()
                error('��������� �� �������� �������.')
            else
                result=binom(res);
            end
        end
        function result = mtimes(b1,b2)
            %��������� �������
            res = b1.pol*b2.pol;
            if ~res.isBinom()
                error('��������� �� �������� �������.')
            else
                result=binom(res);
            end
        end
        function result = mpower(b,pow)
            %���������� � ������� �������
            res = b.pol^pow;
            if ~res.isBinom()
                error('��������� �� �������� �������.')
            else
                result=binom(res);
            end
        end
        function result = mrdivide(b1,b2)
            %������� �������. ������� �����������
            res = b1.pol/b2.pol;
            if ~res.isBinom()
                error('��������� �� �������� �������.')
            else
                result=binom(res);
            end
        end
        function display(b)
            %�����������
            b.pol.display();
        end
        function s = toString(b)
            % ��������� ��������� ������������� ��� ������
            s = b.pol.toString();
        end
    end
end