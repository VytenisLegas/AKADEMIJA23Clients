page 50113 "Client Contract SubPage"
{
    Caption = 'Lines';

    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Client Contract Line";

    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Description; Rec.Description) { }
                field(Quantity; Rec.Quantity) { }
                field("Unit Price"; Rec."Unit Price") { }
                field("Line Amount"; Rec."Line Amount") { Editable = false; }
            }
        }
    }
}