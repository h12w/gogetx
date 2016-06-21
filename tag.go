package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"regexp"
	"strings"

	"gopkg.in/yaml.v2"
)

type PathTag struct {
	Path string         `yaml:"path"`
	Pat  *regexp.Regexp `yaml:"-"`
	Tags []string       `yaml:"tags"`
}

var (
	pathTags = func() []PathTag {
		f, err := os.Open("gogetx-config.yml")
		if err != nil {
			return nil
		}
		defer f.Close()
		buf, err := ioutil.ReadAll(f)
		if err != nil {
			return nil
		}
		var pathTags []PathTag
		if err := yaml.Unmarshal(buf, &pathTags); err != nil {
			return nil
		}
		for i := range pathTags {
			pathTags[i].Pat = regexp.MustCompile(pathTags[i].Path)
		}
		return pathTags
	}()
)

func (v *vcsCmd) customTagSync(root string, goVersion string, tags []string) error {
	path := trimGoPath(root)
	allTags := make(map[string]bool)
	for _, tag := range tags {
		allTags[tag] = true
	}
	for _, pathTag := range pathTags {
		if !pathTag.Pat.MatchString(path) {
			continue
		}
		for _, tag := range pathTag.Tags {
			if allTags[tag] {
				return v.tagSync(root, tag)
			}
		}
		return fmt.Errorf("fail to checkout %s at %v", root, pathTag.Tags)
	}
	return fmt.Errorf("fail to checkout %s at all tags", root)
}

func trimGoPath(root string) string {
	for _, prefix := range gopath {
		path := strings.TrimPrefix(root, prefix)
		if path != root {
			return strings.TrimPrefix(path, "/src/")
		}
	}
	return root
}
