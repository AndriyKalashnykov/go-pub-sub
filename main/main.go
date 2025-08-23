package main

import (
	"time"

	"github.com/andriykalashnykov/go-pub-sub/publisher"
	"github.com/andriykalashnykov/go-pub-sub/pubsub"
	"github.com/andriykalashnykov/go-pub-sub/subscriber"
)

func main() {
	pb := pubsub.NewPubSub(5000)
	pub := publisher.NewPublisher(pb)
	sub := subscriber.NewSubscriber(pb)
	go func() {
		time.Sleep(10 * time.Second)
		pb.Close()
	}()
	go sub.Subscribe()
	go pub.Publish()
	time.Sleep(30 * time.Second)

}
