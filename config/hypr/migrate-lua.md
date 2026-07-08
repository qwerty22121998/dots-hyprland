

# KEY BINDING 

Bind desc
```
bindd = (?<command>.+?), (?<key>.+?), (?<desc>.+?), exec, (?<cmd>.+)
```
```
hl.bind("$command + $key", hl.dsp.exec_cmd("$cmd"), { description = "$desc" })
```



Main mod
```
"\$mainMod( \+)* (?<key>.+?)"
``` 
```
mainMod .. " + $key"
```
