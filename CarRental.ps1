Function Get-Car {
    [CmdletBinding()]


    param(
        [Parameter(
            Mandatory=$true,
            Position=1,
            HelpMessage="How many cars would you like to rent, Sir?"
        )]
        [int]$NumberOfCars,


    
        [Parameter(
            Mandatory = $true,
            Position = 2,
            HelpMessage = "Tell me how many passengers are you going to drive with?"
        )]

        [int] $NumberOfPeople,

        [Parameter(
            Mandatory = $true,
            Position = 3,
            HelpMessage = "How many days would you like to drive?"
        )]

        [int] $Days,


         [Parameter(
            Mandatory=$false,
            Position=4,
            HelpMessage="What type of cars do you want to rent?"
        )]
        [string] $CarType = "Opel_Insignia"
    )



    DynamicParam {
        if ($CarType -eq "Lamborghini") {

            $TypeAttribute = New-Object System.Management.Automation.ParameterAttribute
            $TypeAttribute.Position = 5
            $TypeAttribute.Mandatory = $true
            $TypeAttribute.HelpMessage = "This car is only available for customers with prior reservation, please show me your reservation ID:"

            $attributeCollection = new-object System.Collections.ObjectModel.Collection[System.Attribute]
 
            $attributeCollection.Add($TypeAttribute)
 
            $TypeParam = New-Object System.Management.Automation.RuntimeDefinedParameter('ReservationID', [Int16], $attributeCollection)
 
            $paramDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add('ReservationID', $TypeParam)
            return $paramDictionary
       }
       }





        Begin
        {
       if ($PSBoundParameters.reservationID -and $PSBoundParameters.reservationID -ne 1234) {
           Write-Error "I am sorry, this ID doesn't exist in our data base." -ErrorAction Stop
       }

       
       }


       Process {
    $CarTypes = @{
        Fiat_126p   = @{price = 25,99 };
        Opel_Insignia   = @{price = 50,99}; 
        Autosan = @{price = 399,99};
        Lamborghini = @{price = 1000,99};
    }

        $intsum=$CarTypes[$CarType].price;
        $intsum=$intsum*$Days

      if (!$CarTypes.ContainsKey($CarType)) {
        Write-Host "I am sorry, we don't have it in our offer...";
        
         } 

        else {
            Write-Host -BackgroundColor Yellow -ForegroundColor Black "Mentioned cars are available"
            Write-Host -BackgroundColor Yellow -ForegroundColor Black "You have rented: " $NumberOfCars  $CarType" cars for "$Days" days, for" $NumberOfPeople "people"
            Write-Host -BackgroundColor Yellow -ForegroundColor Black "Our prices have increased due to the COVID19 pandemic. Let's proceed to the payment."
            Write-Host -BackgroundColor Yellow -ForegroundColor Black "The bill is: " ($CarTypes[$CarType].price)*$NumberOfCars*$Days
            Write-Host -BackgroundColor Yellow -ForegroundColor Black "Remember to fasten your seatbelts! This machines are as fast as lightning. Bon voyage!"

        }  
    }
}
