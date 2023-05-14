{
  "version": "1.2",
  "package": {
    "name": "",
    "version": "",
    "description": "",
    "author": "",
    "image": ""
  },
  "design": {
    "board": "alhambra-ii",
    "graph": {
      "blocks": [
        {
          "id": "08b6fd7f-03fa-4cd4-8abb-023a9a156c48",
          "type": "basic.output",
          "data": {
            "name": "SS",
            "pins": [
              {
                "index": "0",
                "name": "D2",
                "value": "4"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 760,
            "y": 72
          }
        },
        {
          "id": "3eb3819b-3183-4090-96d4-af5ec43ad7ab",
          "type": "basic.output",
          "data": {
            "name": "SCLK",
            "pins": [
              {
                "index": "0",
                "name": "D1",
                "value": "1"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 760,
            "y": 168
          }
        },
        {
          "id": "728ccde9-2a39-49e0-8750-c9cb340bd712",
          "type": "basic.output",
          "data": {
            "name": "MOSI",
            "pins": [
              {
                "index": "0",
                "name": "D0",
                "value": "2"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 760,
            "y": 264
          }
        },
        {
          "id": "17166b61-59ca-4acf-8c90-e8a145546f83",
          "type": "basic.output",
          "data": {
            "name": "led",
            "range": "[7:0]",
            "pins": [
              {
                "index": "7",
                "name": "LED0",
                "value": "45"
              },
              {
                "index": "6",
                "name": "LED1",
                "value": "44"
              },
              {
                "index": "5",
                "name": "LED2",
                "value": "43"
              },
              {
                "index": "4",
                "name": "LED3",
                "value": "42"
              },
              {
                "index": "3",
                "name": "LED4",
                "value": "41"
              },
              {
                "index": "2",
                "name": "LED5",
                "value": "39"
              },
              {
                "index": "1",
                "name": "LED6",
                "value": "38"
              },
              {
                "index": "0",
                "name": "LED7",
                "value": "37"
              }
            ],
            "virtual": false
          },
          "position": {
            "x": 760,
            "y": 328
          }
        },
        {
          "id": "6949dcb8-a774-4078-8b12-0e79a9eb1205",
          "type": "basic.code",
          "data": {
            "code": "\n\n//@include clock_divider.v\n//@include basickey.v\n//@include tm1638.v\n\n\n top u1(\n    .clk,\n    .tm_cs,\n    .tm_clk,\n    .tm_dio,\n    .led\n    );",
            "params": [],
            "ports": {
              "in": [
                {
                  "name": "clk"
                }
              ],
              "out": [
                {
                  "name": "tm_cs"
                },
                {
                  "name": "tm_clk"
                },
                {
                  "name": "tm_dio"
                },
                {
                  "name": "led",
                  "range": "[7:0]",
                  "size": 8
                }
              ]
            }
          },
          "position": {
            "x": 200,
            "y": 56
          },
          "size": {
            "width": 448,
            "height": 288
          }
        }
      ],
      "wires": [
        {
          "source": {
            "block": "6949dcb8-a774-4078-8b12-0e79a9eb1205",
            "port": "tm_cs"
          },
          "target": {
            "block": "08b6fd7f-03fa-4cd4-8abb-023a9a156c48",
            "port": "in"
          }
        },
        {
          "source": {
            "block": "6949dcb8-a774-4078-8b12-0e79a9eb1205",
            "port": "tm_clk"
          },
          "target": {
            "block": "3eb3819b-3183-4090-96d4-af5ec43ad7ab",
            "port": "in"
          }
        },
        {
          "source": {
            "block": "6949dcb8-a774-4078-8b12-0e79a9eb1205",
            "port": "tm_dio"
          },
          "target": {
            "block": "728ccde9-2a39-49e0-8750-c9cb340bd712",
            "port": "in"
          }
        },
        {
          "source": {
            "block": "6949dcb8-a774-4078-8b12-0e79a9eb1205",
            "port": "led"
          },
          "target": {
            "block": "17166b61-59ca-4acf-8c90-e8a145546f83",
            "port": "in"
          },
          "size": 8
        }
      ]
    }
  },
  "dependencies": {}
}