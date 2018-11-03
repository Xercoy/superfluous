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

	// create the request
	request, err := http.NewRequest("GET", fullURL, nil)
	require.Nil(err)

	// create a recorder for the test
	responseRecorder := httptest.NewRecorder()

	// call the handler function and execute the request
	mainHandler(responseRecorder, request)

	// extract the response
	response := responseRecorder.Result()
	defer response.Body.Close()

	// ensure 200 response received
	assert.Equal(http.StatusOK, response.StatusCode)

	// get the response payload of the HTTP request
	responseBody, err := ioutil.ReadAll(response.Body)
	require.Nil(err)

	// assert the default message is given
	assert.Equal(string(responseBody), defaultMessage)
}
