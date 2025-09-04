{
  checkOptionAccessor ? _: true,
  persistentDirectories ? [],
  persistentFiles ? [],
}:
(import ./mkDynamicPreset.nix) {
  checkOptionAccessor = checkOptionAccessor;
  persistentDirectoriesAccessor = _: persistentDirectories;
  persistentFilesAccessor = _: persistentFiles;
}
