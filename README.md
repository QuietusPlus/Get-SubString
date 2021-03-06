# Description

Get `-InputObject` and return everything between `-From` and `-Until` (or until `-EmptyLine`). The script currently supports the following operations:

| Example Title | `-InputObject` | `-From` | `-Until` | `-EmptyLine` |
|:--------------|:--------------:|:-------:|:--------:|:------------:|
| Get `-InputObject` `-From` until last line | X | X | | |
| Get `-InputObject` `-From` until empty line | X | X | | X |
| Get `-InputObject` `-From` `-Until` | X | X | X | |
| Get `-InputObject` from first line `-Until` | X | | X | |

# Examples

## Base Data

```PowerShell
$InputString = Get-Help | Out-String -Stream | Select-Object -First 15
```

```
TOPIC
    Windows PowerShell Help System

SHORT DESCRIPTION
    Displays help about Windows PowerShell cmdlets and concepts.

LONG DESCRIPTION
    Windows PowerShell Help describes Windows PowerShell cmdlets,
    functions, scripts, and modules, and explains concepts, including
    the elements of the Windows PowerShell language.

    Windows PowerShell does not include help files, but you can read the
    help topics online, or use the Update-Help cmdlet to download help files
    to your computer and then use the Get-Help cmdlet to display the help
```

## Get -InputObject -From until last line

```PowerShell
Get-SubString -InputObject $InputString -From 'Short Description'
```

```
SHORT DESCRIPTION
    Displays help about Windows PowerShell cmdlets and concepts.

LONG DESCRIPTION
    Windows PowerShell Help describes Windows PowerShell cmdlets,
    functions, scripts, and modules, and explains concepts, including
    the elements of the Windows PowerShell language.

    Windows PowerShell does not include help files, but you can read the
    help topics online, or use the Update-Help cmdlet to download help files
    to your computer and then use the Get-Help cmdlet to display the help
```

## Get -InputObject -From until empty line

```PowerShell
Get-SubString -InputObject $InputString -From 'Short Description' -EmptyLine
```

```
SHORT DESCRIPTION
    Displays help about Windows PowerShell cmdlets and concepts.
```

## Get -InputObject -From -Until

```PowerShell
Get-SubString -InputObject $InputString -From 'Short Description' -Until 'elements'
```

```
SHORT DESCRIPTION
    Displays help about Windows PowerShell cmdlets and concepts.

LONG DESCRIPTION
    Windows PowerShell Help describes Windows PowerShell cmdlets,
    functions, scripts, and modules, and explains concepts, including
    the elements
```

## Get -InputObject -Until

```PowerShell
Get-SubString -InputObject $InputString -Until 'elements'
```

```
TOPIC
    Windows PowerShell Help System

SHORT DESCRIPTION
    Displays help about Windows PowerShell cmdlets and concepts.

LONG DESCRIPTION
    Windows PowerShell Help describes Windows PowerShell cmdlets,
    functions, scripts, and modules, and explains concepts, including
    the elements
```
