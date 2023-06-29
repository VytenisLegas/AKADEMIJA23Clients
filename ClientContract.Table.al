table 50110 "Client Contract"
{
    Caption = 'Client Contract';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
        }
        field(10; "Client No."; Code[20])
        {
            Caption = 'Client No.';
            TableRelation =
                if ("Client Type" = const(Customer)) Customer
            else
            if ("Client Type" = const(Vendor)) Vendor;
        }
        field(11; "Client Type"; Enum "Client Contract Type")
        {

        }

        field(20; "Contract Amount"; Decimal)
        {
            Caption = 'Contract Amount';
        }
        field(21; "Contract Start Date"; Date)
        {
            Caption = 'Contract Start Date';

            trigger OnValidate()
            var
                BadDateErr: Label 'Prad=ios data negali b9ti v4lesn4 nei pabaigos data';
            begin
                if ("Contract End Date" <> 0D) and ("Contract Start Date" > "Contract End Date") then
                    Error(BadDateErr);
            end;
        }
        field(22; "Contract End Date"; Date)
        {
            Caption = 'Contract End Date';

            trigger OnValidate()
            var
                BadDateErr: Label 'Prad=ios data negali b9ti v4lesn4 nei pabaigos data';
            begin
                if ("Contract End Date" <> 0D) and ("Contract Start Date" > "Contract End Date") then
                    Error(BadDateErr);
            end;
        }
    }

    keys
    {
        key(Key1; "Contract No.") { Clustered = true; }
        key(Key2; "Contract Start Date", "Contract End Date") { }
    }

    trigger OnInsert()
    var
        ClientContractSetup: Record "Client Contract Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        //Message('Before %1', ClientContractSetup."Contract Nos");       
        //ClientContractSetup.Get();
        //Message('After %1', ClientContractSetup."Contract Nos");

        if "Contract No." = '' then begin
            ClientContractSetup.Get();
            ClientContractSetup.TestField("Contract Nos");
            "Contract No." := NoSeriesManagement.GetNextNo(ClientContractSetup."Contract Nos", WorkDate(), true);
        end;
    end;
}