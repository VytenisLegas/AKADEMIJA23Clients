report 50110 "Client Contract"
{
    Caption = 'Client Contract';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName2;

    dataset
    {
        dataitem("Client Contract"; "Client Contract")
        {
            PrintOnlyIfDetail = true;

            column(Contract_No_; "Contract No.") { }
            column(Client_Type; "Client Type") { }
            column(Client_No_; "Client No.") { }
            column(Contract_Start_Date; "Contract Start Date") { }
            column(Contract_End_Date; "Contract End Date") { }
            column(Contract_Amount; "Contract Amount") { }

            dataitem("Client Contract Line"; "Client Contract Line")
            {
                DataItemLink = "Contract No." = field("Contract No.");
                DataItemTableView = sorting("Contract No.", "Line No.");

                column(Line_No_; "Line No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Amount; "Line Amount") { }

                trigger OnPreDataItem()
                begin
                    if not IsEmpty then
                        TotalContractAmountLine += "Client Contract"."Contract Amount";
                end;
            }

            trigger OnPreDataItem()
            begin
                SetFilter("Contract Start Date", '%1..', StartingDateFilter);
            end;

            trigger OnAfterGetRecord()
            var
                ClientContractLine: Record "Client Contract Line";
            begin
                ClientContractLine.SetRange("Contract No.", "Contract No.");
                if not ClientContractLine.IsEmpty then
                    TotalContractAmount += "Contract Amount";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StartingDateFilterCtrl; StartingDateFilter)
                    {
                        Caption = 'Pradžios datos filtras';
                    }
                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/Layout/Client Contract.rdl';
        }
        layout(LayoutName2)
        {
            Type = RDLC;
            LayoutFile = './src/Layout/Client Contract 2.rdl';
        }
    }

    var
        TotalContractAmount: Decimal;
        TotalContractAmountLine: Decimal;
        StartingDateFilter: Date;

    trigger OnInitReport()
    begin
        StartingDateFilter := WorkDate();
    end;

    trigger OnPreReport()
    begin
        if StartingDateFilter = 0D then
            Error('Nenurodytas datos filtras');
    end;

    trigger OnPostReport()
    begin
        Message('TotalContractAmount %1\TotalContractAmountLine %2', TotalContractAmount, TotalContractAmountLine);
    end;
}