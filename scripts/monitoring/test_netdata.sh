#!/bin/bash

stress --cpu 4 --timeout 30

echo "Load test complete. Check the Netdata dashboard for metrics."
