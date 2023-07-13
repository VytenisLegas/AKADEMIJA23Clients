table 50112 "Client Contract Line"
{
    Caption = 'Client Contract Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(20; Quantity; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                "Line Amount" := Round(Quantity * "Unit Price");
            end;
        }
        field(30; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                "Line Amount" := Round(Quantity * "Unit Price");
            end;
        }
        field(40; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
        }
    }

    keys
    {
        key(Key1; "Contract No.", "Line No.") { Clustered = true; }
    }
}