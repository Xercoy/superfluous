package main

import (
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// TestBasicHello asserts the default response.
func TestBasicHello(t *testing.T) {
	require := require.New(t)
	assert := assert.New(t)

	fullURL := defaultEndpoint + ":" + defaultPort

	t.Run("GET to default endpoint OK", func(t *testing.T) {
		// create the request
		request, err := http.NewRequest("GET", fullURL, nil)
		require.Nil(err)

		// create a recorder for the test
		respRecorder := httptest.NewRecorder()

		// call the handler function and execute the request
		mainHandler(respRecorder, request)

		// extract the response
		response := respRecorder.Result()
		defer response.Body.Close()

		// ensure 200 response received
		assert.Equal(http.StatusOK, response.StatusCode)

		// get the response payload of the HTTP request
		responseBody, err := ioutil.ReadAll(response.Body)
		require.Nil(err)

		// assert the default message is given
		assert.Equal(string(responseBody), defaultMessage)
	})

	t.Run("GET to different port ERROR", func(t *testing.T) {
		request, err := http.NewRequest("POST", fullURL, nil)
		require.NoError(err)

		respRecorder := httptest.NewRecorder()
		mainHandler(respRecorder, request)

		response := respRecorder.Result()
		defer response.Body.Close()

		assert.Equal(http.StatusOK, response.StatusCode)

		responseBody, err := ioutil.ReadAll(response.Body)
		require.Nil(err)

		panic(string(responseBody))

		assert.Equal(string(responseBody), defaultMessage)
	})
}
