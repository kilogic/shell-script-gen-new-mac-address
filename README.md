# Generate a new MAC address


## SETUP:

```
chmod u+x get-new-mac.sh
```

## SYNOPSIS:

```
get-new-mac.sh [-h] | [-u] [-d <string>]

```

## DESCRIPTION:

Universal vs Locally administerd - some distros only allow the following (locally administered) address convention:
  x2-xx-xx-xx-xx-xx
  x6-xx-xx-xx-xx-xx
  xA-xx-xx-xx-xx-xx
  xE-xx-xx-xx-xx-xx

-h Prints some help/usage example
-d Allows for specifying a delimiter
-u Might generate a universally administered address

