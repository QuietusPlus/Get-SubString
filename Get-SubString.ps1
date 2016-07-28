<#
    The MIT License (MIT)

    Copyright (c) 2016 QuietusPlus

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
#>

function Get-SubString {
    <#
    .SYNOPSIS
        Get -InputObject and return everything between -From and -Until (or until -EmptyLine).

    .DESCRIPTION
        Get -InputObject and return everything between -From and -Until (or until -EmptyLine).

    .EXAMPLE
        C:\PS> Get-SubString -InputObject (Get-Help) -From 'Short Description'

    .EXAMPLE
        C:\PS> Get-SubString -InputObject (Get-Help) -From 'Short Description' -EmptyLine

    .EXAMPLE
        C:\PS> Get-SubString -InputObject (Get-Help) -From 'Short Description' -Until 'elements'

    .EXAMPLE
        C:\PS> Get-SubString -InputObject (Get-Help) -Until 'elements'

    .LINK
        https://quietusplus.github.io/Get-SubString

    .LINK
        https://github.com/QuietusPlus/Get-SubString
    #>

    [CmdletBinding(DefaultParameterSetName='From')]
    [OutputType([string])]

    param(
        # Object to be processed.
        [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
        $InputObject,

        # Start capturing at the specified string.
        [Parameter(Position=1, ValueFromPipelineByPropertyName=$true)]
        [Parameter(Mandatory=$true, ParameterSetName='From')]
        [Parameter(Mandatory=$true, ParameterSetName='FromUntil')]
        [Parameter(Mandatory=$true, ParameterSetName='EmptyLine')]
        [string]
        $From,

        # Stop capturing once the specified string has been reached.
        [Parameter(Position=2, ValueFromPipelineByPropertyName=$true)]
        [Parameter(Mandatory=$true, ParameterSetName='Until')]
        [Parameter(Mandatory=$true, ParameterSetName='FromUntil')]
        [string]
        $Until,

        # Stop capturing once a blank line has been reached.
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [Parameter(Mandatory=$true, ParameterSetName='EmptyLine')]
        [switch]
        $EmptyLine
    )

    begin {
        # Check if -From has been specified, if so use it
        if ($From) { $fromCondition = "(?:$From)"
        # Otherwise start from top of -InputObject
        } else { $fromCondition = '' }

        # Check if -EmptyLine has been specified, if so process until empty line has been reached
        if ($EmptyLine) { $untilCondition = '(?:\r*\n){2}'
        # Otherwise use -Until if it has been specified
        } elseif ($Until -notlike $null) { $untilCondition = "(?:$Until)"
        # Otherwise return everything till end of -InputObject
        } else { $untilCondition = '(?:.+)' }
    }

    process {
        [regex]::Match($($InputObject | Out-String), "(?s)$fromCondition(.*?)$untilCondition", @('MultiLine', 'Ignorecase')).Value
    }
}
