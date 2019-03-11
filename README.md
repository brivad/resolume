# Resolume Composition Tools

This script read a Resolume® v3 composition file (.avc)

## Reading a composition:

```
composition = ResolumeComposition.new("filename.avc")
```

## printing clips info:

```
composition.clips_info
```

## to copy all clips in a given directory

```
composition.copy_clips(dir)
```

dir must be absolute path with r/w access

a new composition file (.avc) is saved with the new paths inside

## 🖖
