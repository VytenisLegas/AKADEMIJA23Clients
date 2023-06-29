page 50111 "Client Contract Card"
{
    Caption = 'Client Contract';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Client Contract";

    layout
    {
        area(Content)
        {
            group(Genaral)
            {
                Caption = 'General';
                field("Contract No."; Rec."Contract No.")
                {
                    ToolTip = 'Contract No.';
                }
                field("Client Type"; Rec."Client Type")
                {
                    ToolTip = 'Client Type';
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Client No.';
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                    ToolTip = 'Contract Amount';
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ToolTip = 'Contract Start Date';
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ToolTip = 'Contract End Date';
                }
            }
        }
    }
}