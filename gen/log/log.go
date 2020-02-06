package log

import "log"

func init() {
	log.SetFlags(0)
}

var Debug = false

func Println(args ...interface{}) {
	log.Println(args...)
}

func Printf(s string, args ...interface{}) {
	log.Printf(s, args...)
}

func Fatalln(args ...interface{}) {
	log.Fatalln(args...)
}

func Fatalf(s string, args ...interface{}) {
	log.Fatalf(s, args...)
}

func Debugln(args ...interface{}) {
	if Debug {
		log.Println(args...)
	}
}

func Debugf(s string, args ...interface{}) {
	if Debug {
		log.Printf(s, args...)
	}
}
