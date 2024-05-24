package main

import (
	"fmt"
	"github.com/google/go-containerregistry/pkg/name"
)

func main() {

	//	dockerfile.Parse([]byte(`
	//FROM scratch
	//RUN echo haha > /tmp/test
	//`))
	reference, err := name.ParseReference("centos:7@sha256:eeb6ee3f44bd0b5103bb561b4c16bcb82328cfe5809ab675bb17ab3a16c517c9", name.WeakValidation)
	fmt.Println(reference, err)
}
