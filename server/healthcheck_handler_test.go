package main

import (
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// TestHealthCheckOK validates the health endpoint
func TestHealthCheckOK(t *testing.T) {
	require := require.New(t)
	assert := assert.New(t)

	t.Run("GET to health endpoint OK", func(t *testing.T) {
		request, err := http.NewRequest("GET", healthCheckMessage, nil)
		require.Nil(err)

		// create response
		respRecorder := httptest.NewRecorder()

		// call handler
		healthCheckHandler(respRecorder, request)

		response := respRecorder.Result()
		defer response.Body.Close()

		assert.Equal(http.StatusOK, response.StatusCode)

		responseBody, err := ioutil.ReadAll(response.Body)
		require.Nil(err)

		assert.Equal(string(responseBody), healthCheckMessage)
	})
}
